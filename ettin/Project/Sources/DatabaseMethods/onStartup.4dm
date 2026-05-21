var $llama : cs:C1710.llama.llama
var $huggingfaces : cs:C1710.event.huggingfaces
var $embeddings; $rerank : cs:C1710.event.huggingface
var $homeFolder : 4D:C1709.Folder

var $file : 4D:C1709.File
var $URL : Text
var $port : Integer

var $event : cs:C1710.event.event
$event:=cs:C1710.event.event.new()

$event.onError:=Formula:C1597(OnModelDownloaded)
$event.onSuccess:=Formula:C1597(OnModelDownloaded)
$event.onData:=Formula:C1597(LOG EVENT:C667(Into 4D debug message:K38:5; This:C1470.file.fullName+":"+String:C10((This:C1470.range.end/This:C1470.range.length)*100; "###.00%")))
$event.onResponse:=Formula:C1597(LOG EVENT:C667(Into 4D debug message:K38:5; This:C1470.file.fullName+":download complete"))
$event.onTerminate:=Formula:C1597(LOG EVENT:C667(Into 4D debug message:K38:5; (["process"; $1.pid; "terminated!"].join(" "))))

$homeFolder:=Folder:C1567(fk home folder:K87:24).folder(".GGUF")
var $max_position_embeddings; $batch_size; $parallel : Integer
var $ubatch_size; $n_gpu_layers; $threads; $threads_batch; $batches : Integer
var $ctx_size; $temp; $min_p; $top_k; $top_p; $repeat_penalty; $presence_penalty : Integer

var $folder : 4D:C1709.Folder
var $logFile : 4D:C1709.File
var $path; $pooling : Text
var $options : Object

$folder:=$homeFolder.folder("ettin-encoder")
$path:="ettin-encoder-400m-Q8_0.gguf"
$URL:="keisuke-miyako/ettin-encoder-gguf"

$max_position_embeddings:=1024
$pooling:="mean"
$batch_size:=$max_position_embeddings
$ubatch_size:=$max_position_embeddings
$n_gpu_layers:=-1

$batches:=4
$threads:=2
$threads_batch:=2

$logFile:=$folder.file("llama.log")
$folder.create()
If (Not:C34($logFile.exists))
	$logFile.setContent(4D:C1709.Blob.new())
End if 

$port:=8082
$options:={\
embeddings: True:C214; \
pooling: $pooling; \
ctx_size: $max_position_embeddings*$batches; \
batch_size: $batch_size*$batches; \
ubatch_size: $ubatch_size; \
parallel: $batches; \
threads: $threads; \
threads_batch: $threads_batch; \
threads_http: $batches+1; \
log_file: $logFile; \
log_disable: False:C215; \
n_gpu_layers: $n_gpu_layers}

$embeddings:=cs:C1710.event.huggingface.new($folder; $URL; $path)
$huggingfaces:=cs:C1710.event.huggingfaces.new([$embeddings])
$llama:=cs:C1710.llama.llama.new($port; $huggingfaces; $homeFolder; $options; $event)

$folder:=$homeFolder.folder("bge-m3")
$path:="bge-m3-Q8_0.gguf"
$URL:="keisuke-miyako/bge-m3-gguf-q8_0"

$max_position_embeddings:=1024
$pooling:="cls"
$batch_size:=$max_position_embeddings
$ubatch_size:=$max_position_embeddings
$n_gpu_layers:=-1

$batches:=4
$threads:=2
$threads_batch:=2

$logFile:=$folder.file("llama.log")
$folder.create()
If (Not:C34($logFile.exists))
	$logFile.setContent(4D:C1709.Blob.new())
End if 

$port:=8083
$options:={\
embeddings: True:C214; \
pooling: $pooling; \
ctx_size: $max_position_embeddings*$batches; \
batch_size: $batch_size*$batches; \
ubatch_size: $ubatch_size; \
parallel: $batches; \
threads: $threads; \
threads_batch: $threads_batch; \
threads_http: $batches+1; \
log_file: $logFile; \
log_disable: False:C215; \
n_gpu_layers: $n_gpu_layers}

$embeddings:=cs:C1710.event.huggingface.new($folder; $URL; $path)
$huggingfaces:=cs:C1710.event.huggingfaces.new([$embeddings])
$llama:=cs:C1710.llama.llama.new($port; $huggingfaces; $homeFolder; $options; $event)

