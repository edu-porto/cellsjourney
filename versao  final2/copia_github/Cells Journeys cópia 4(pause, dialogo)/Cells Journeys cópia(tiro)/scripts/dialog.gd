extends Control

# array onde contém o texto pois queremos várias partes de diálogo
var dialog = [
	"Uma das formas de prevenção ao câncer é a realização de atividades físicas como esportes aeróbios que envolvem correr, andar de bicicleta, natação, dança, entre outros",
	"Para isso, você pode utilizar esse tênis que você acabou de encontrar para tentar realizar a pratica de uma dessas atividades",
	"Pressione shift para correr e a barra de espaço duas vezes para dar um duplo pulo"
]

var dialog_index = 0 # para separar em diferentes diálogos "atuais"
var finished = false # para saber se acabaram ou não os diálogos

func _ready():
	hide()
	load_dialog() #carrega o diálogo
	
func _process(_delta):
	$"setinha".visible = finished
	#$"Rogerchammas".visible = finished
	if Input.is_action_just_pressed("ui_accept"): 
		load_dialog() #se for pressionado, carrega o próximo diálogo
	
func load_dialog(): # função de carregar dialogo
	if dialog_index < dialog.size(): # tem que ser menor para não passar a qtd desejada
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index] #puxa o nó de richtext.bbcode e iguala ao índice do diálogo
		$RichTextLabel.percent_visible = 0 # percentual visível do texto(vai de 0 a 1), para o texto ir andando aos poucos
		$Tween.interpolate_property( # vai interpolar o percentual visível do texto de forma linear de 0 a 1 em 1 segundo
			$RichTextLabel, "percent_visible", 0, 1, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
		#print("roger lindo")
	else:
		queue_free()# se for maior que o tamanho, remove tudo
		
	dialog_index += 1 #soma um para cada diálogo carregado

func _on_Tween_tween_completed(_object, _key):
	finished = true

func _on_Area2D_body_entered(_body):
	show()
