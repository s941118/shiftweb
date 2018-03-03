CKEDITOR.editorConfig = function( config ) {
	config.toolbarGroups = [
		{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
		{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
		{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
		{ name: 'forms', groups: [ 'forms' ] },
		{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
		'/',
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'styles', groups: [ 'styles' ] },
		{ name: 'colors', groups: [ 'colors' ] },
		{ name: 'insert', groups: [ 'insert' ] },
		{ name: 'links', groups: [ 'links' ] },
		{ name: 'tools', groups: [ 'tools' ] },
		{ name: 'others', groups: [ 'others' ] },
		{ name: 'about', groups: [ 'about' ] }
	];

	config.removeButtons = 'BidiLtr,BidiRtl,Language,Anchor,Flash,Image,SpecialChar,PageBreak,Iframe,Smiley,About,SelectAll,Scayt,Replace,Find,Checkbox,Radio,Textarea,Select,ImageButton,HiddenField,Print,Save,Templates,Copy,Paste,Cut,PasteText,Preview,NewPage,Form,TextField,Button,PasteFromWord,RemoveFormat,CopyFormatting,Styles,CreateDiv,Blockquote,Source,ShowBlocks,Maximize';
	config.font_names = '新細明體;細明體;標楷體;微軟正黑體;Arial;Arial Black;Comic Sans MS;Courier New;Tahoma;Times New Roman;Verdana;';
	config.fontSize_sizes = '12/12px;13/13px;15/15px;16/16px;18/18px;20/20px;22/22px;24/24px;36/36px;48/48px;';
	config.format_tags = 'h1;h2;h3;h4;h5;p;address';
	config.undoStackSize = 50;
};

CKEDITOR.on( 'dialogDefinition', function( ev ) {
  var dialogName = ev.data.name;
  var dialogDefinition = ev.data.definition;

  if ( dialogName == 'table' ) {
    var info = dialogDefinition.getContents( 'info' );

    info.get( 'txtWidth' )[ 'default' ] = '100%';       // Set default width to 100%
  //   info.get( 'txtBorder' )[ 'default' ] = '0';         // Set default border to 0
  //   info.get( 'txtCellSpace' )[ 'default' ] = '0';
		// info.get( 'txtCellPad' )[ 'default' ] = '0';
  }
});