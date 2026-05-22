## [jhu-clsp/ettin-encoder-1b](https://huggingface.co/jhu-clsp/ettin-encoder-1b)

|`max_position_embeddings`|`hidden_size`|`num_hidden_layers`|`pooling`
|-:|-:|-:|-:|
|`7999`|`1792`|`28`|`mean`

```4d
var $llama : cs.AIKit.OpenAI
$llama:=cs.AIKit.OpenAI.new()
$llama.baseURL:="http://127.0.0.1:8082/v1"

var $batch : cs.AIKit.OpenAIEmbeddingsResult
$batch:=$llama.embeddings.create($input)

var $embedding : 4D.Vector
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
	ALERT("should score low:"+String($cosineSimilarity1)+"\r"\
	+"should score high:"+String($cosineSimilarity2))
End if
```

## Ettin 1b

<img width="480" height="175" alt="Screenshot 2026-05-22 at 8 47 34" src="https://github.com/user-attachments/assets/d69f0d33-1e70-4927-8879-6edae8879d34" />

## Ettin 400m

<img width="480" height="175" alt="Screenshot 2026-05-22 at 8 41 18" src="https://github.com/user-attachments/assets/9df87649-a1ef-479e-8202-7c31a7f13508" />

## BGE M3

<img width="480" height="175" alt="Screenshot 2026-05-22 at 8 42 44" src="https://github.com/user-attachments/assets/bb9b12f5-d5d3-48aa-b08c-ca7db616789d" />
