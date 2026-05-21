//%attributes = {"invisible":true}
var $llama : cs:C1710.AIKit.OpenAI
$llama:=cs:C1710.AIKit.OpenAI.new()
$llama.baseURL:="http://127.0.0.1:8083/v1"

var $batch : cs:C1710.AIKit.OpenAIEmbeddingsResult
$batch:=$llama.embeddings.create($input)

var $embedding : 4D:C1709.Vector
var $inputs : Collection
$inputs:=[]
$inputs.push("Die aktuellen Arbeitslosenzahlen zeigen einen deutlichen Rückgang.")
$inputs.push("The actual unemployment figures were far lower than what the report claimed.")
$inputs.push("Sie zog den Fingerhut über den Zeigefinger, bevor sie mit dem Nähen begann.")
$inputs.push("She pressed the thimble firmly onto her fingertip to push the needle through the thick fabric.")

$batch:=$llama.embeddings.create($inputs)

var $embeddings : Collection
If ($batch.success)
	$embeddings:=$batch.embeddings
	var $cosineSimilarity : Real
	$cosineSimilarity1:=$embeddings[0].embedding.cosineSimilarity($embeddings[1].embedding)
	$cosineSimilarity2:=$embeddings[2].embedding.cosineSimilarity($embeddings[3].embedding)
	ALERT:C41("should score low:"+String:C10($cosineSimilarity1)+"\r"\
		+"should score high:"+String:C10($cosineSimilarity2))
End if 

