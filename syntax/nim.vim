" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if v:version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

" Keep user-supplied options
if !exists('nim_highlight_numbers')
  let nim_highlight_numbers = 1
endif
if !exists('nim_highlight_builtins')
  let nim_highlight_builtins = 1
endif
if !exists('nim_highlight_exceptions')
  let nim_highlight_exceptions = 1
endif
if !exists('nim_highlight_space_errors')
  let nim_highlight_space_errors = 1
endif
if !exists('nim_highlight_special_vars')
  let nim_highlight_special_vars = 1
endif

if exists('nim_highlight_all')
  let nim_highlight_numbers      = 1
  let nim_highlight_builtins     = 1
  let nim_highlight_exceptions   = 1
  let nim_highlight_space_errors = 1
  let nim_highlight_special_vars = 1
endif

syn region nimBrackets       contained extend keepend matchgroup=Bold start=+\(\\\)\@<!\[+ end=+]\|$+ skip=+\\\s*$\|\(\\\)\@<!\\]+ contains=@tclCommandCluster

syn match   nimType          "\<[A-Z]\w*"

syn keyword nimKeyword       addr and as asm atomic
syn keyword nimKeyword       bind block
syn keyword nimKeyword       case concept converter
syn keyword nimKeyword       defer discard distinct div do
syn keyword nimKeyword       elif else end enum except export
syn keyword nimKeyword       finally for from
syn keyword nimKeyword       generic
syn keyword nimKeyword       if import in interface is isnot iterator
syn keyword nimKeyword       let
syn keyword nimKeyword       mixin using mod
syn keyword nimKeyword       not notin
syn keyword nimKeyword       object out
syn keyword nimKeyword       proc func method macro template iterator converter nextgroup=nimFunction skipwhite
syn keyword nimKeyword       raise ref
syn keyword nimKeyword       shared
syn keyword nimKeyword       try tuple
syn keyword nimKeyword       var vtref vtptr
syn keyword nimKeyword       when while with without
syn keyword nimKeyword       xor
syn keyword nimKeyword       yield
" Orange specific highlight
syn keyword nimBuiltin       nil result
" Pink specific highlight
syn keyword nimOperator      const let type break continue return
" Unsafe specific highlight
syn keyword nimException     static include ptr cast equalmem equalMem alloc alloc0 realloc dealloc zeromem zeroMem copymem copyMem movemem moveMem

syn match   nimFunction      "[a-zA-Z_][a-zA-Z0-9_]*\|`.*`" contained
syn match   nimClass         "[a-zA-Z_][a-zA-Z0-9_]*\|`.*`" contained
syn keyword nimRepeat        for while
syn keyword nimConditional   if elif else case of
syn keyword nimOperator      and or not xor shl shr div mod in notin is isnot as
syn match   nimOperator      +[.][.]+
syn match   nimOperator      +[-=+/<>@$~&%|!?^\\]*[=]+
syn match   nimOperator      "[-+/<>@$~&%|!?^\\]*"
syn match   nimOperator      "[∙∘×★⊗⊘⊙⊛⊠⊡∩∧⊓]" " same priority as * (multiplication)
syn match   nimOperator      "[±⊕⊖⊞⊟∪∨⊔]"      " same priority as + (addition)
syn match   nimComment       "#.*$" contains=nimTodo,@Spell
syn region  nimComment       start="#\[" end="\]#" contains=nimTodo,@Spell
syn keyword nimTodo          TODO FIXME XXX contained
syn keyword nimBoolean       true false
syn match   nimConstant      '[{}\[\]()]'
syn match   nimPreCondit     '{\.\|\.}'
" syn match   nimRepeat        '\.\k\+'
" syn match   nimRepeat        '\(?:[a-zA-Z]*\.\)\k\+'
" syn match   nimEscape        "[a-zA-Z]\w*\s\?("
" syn region  nimEscape        start=+\k\+(+ skip=+[\w]*+ end=+)+ contains=nimBuiltin,nimKeyword,nimString,nimRawString,nimBoolean,nimOperator
" syn match   nimEscape        "\w*[\(](\s+\n?\w*\s?)[\)]\n?" " TODO

" Strings
syn region nimString start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=nimEscape,nimEscapeError,@Spell
syn region nimString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=nimEscape,nimEscapeError,@Spell
syn region nimString start=+"""+ end=+"""+ keepend contains=nimEscape,nimEscapeError,@Spell
syn region nimRawString matchgroup=Normal start=+[rR]"+ end=+"+ skip=+\\\\\|\\"+ contains=@Spell

syn match  nimEscape		+\\[abfnrtv'"\\]+ contained
syn match  nimEscape		"\\\o\{1,3}" contained
syn match  nimEscape		"\\x\x\{2}" contained
syn match  nimEscape		"\(\\u\x\{4}\|\\U\x\{8}\)" contained
syn match  nimEscape		"\\$"

syn match nimEscapeError "\\x\x\=\X" display contained

if nim_highlight_numbers == 1
  " numbers (including longs and complex)
  let s:dec_num = '\d%(_?\d)*'
  let s:int_suf = '%(''%(%(i|I|u|U)%(8|16|32|64)|u|U))'
  let s:float_suf = '%(''%(%(f|F)%(32|64|128)?|d|D))'
  let s:exp = '%([eE][+-]?'.s:dec_num.')'
  exe 'syn match nimNumber /\v<0[bB][01]%(_?[01])*%('.s:int_suf.'|'.s:float_suf.')?>/'
  exe 'syn match nimNumber /\v<0[ocC]\o%(_?\o)*%('.s:int_suf.'|'.s:float_suf.')?>/'
  exe 'syn match nimNumber /\v<0[xX]\x%(_?\x)*%('.s:int_suf.'|'.s:float_suf.')?>/'
  exe 'syn match nimNumber /\v<'.s:dec_num.'%('.s:int_suf.'|'.s:exp.'?'.s:float_suf.'?)>/'
  exe 'syn match nimNumber /\v<'.s:dec_num.'\.'.s:dec_num.s:exp.'?'.s:float_suf.'?>/'
  unlet s:dec_num s:int_suf s:float_suf s:exp
endif

if nim_highlight_builtins == 1
  " builtin functions, types and objects, not really part of the syntax
  syn keyword nimBuiltin int int8 int16 int32 int64 uint uint8 uint16 uint32 uint64 float float32 float64
  syn keyword nimBuiltin bool void chr char string cstring pointer range array openarray openArray seq varargs varArgs
  syn keyword nimBuiltin set Byte Natural Positive Conversion
  syn keyword nimBuiltin BiggestInt BiggestFloat cchar cschar cshort cint csize cuchar cushort
  syn keyword nimBuiltin clong clonglong cfloat cdouble clongdouble cuint culong culonglong cchar
  syn keyword nimBuiltin CompileDate CompileTime nimversion nimVersion nimmajor nimMajor
  syn keyword nimBuiltin nimminor nimMinor nimpatch nimPatch cpuendian cpuEndian hostos hostOS hostcpu hostCPU inf
  syn keyword nimBuiltin neginf nan QuitSuccess QuitFailure dbglinehook dbgLineHook stdin
  syn keyword nimBuiltin stdout stderr defined new high low sizeof succ pred
  syn keyword nimBuiltin inc dec newseq newSeq len incl excl card ord chr ze ze64
  syn keyword nimBuiltin tou8 toU8 tou16 toU16 tou32 toU32 abs min max add repr
  syn match   nimBuiltin "\<contains\>"
  syn keyword nimBuiltin tofloat toFloat tobiggestfloat toBiggestFloat toint toInt tobiggestint toBiggestInt
  syn keyword nimBuiltin addquitproc addQuitProc
  syn keyword nimBuiltin copy setlen setLen newstring newString
  syn keyword nimBuiltin assert
  syn keyword nimBuiltin typedesc typed untyped stmt expr
  syn keyword nimBuiltin echo swap getrefcount getRefcount getcurrentexception getCurrentExceptionMsg
  syn keyword nimBuiltin getoccupiedmem getOccupiedMem getfreemem getFreeMem gettotalmem getTotalMem isnil isNil seqtoptr seqToPtr
  syn keyword nimBuiltin find push pop GC_disable GC_enable GC_fullCollect
  syn keyword nimBuiltin GC_setStrategy GC_enableMarkAndSweep GC_Strategy
  syn keyword nimBuiltin GC_disableMarkAndSweep GC_getStatistics
  syn keyword nimBuiltin GC_ref GC_unref quit
  syn keyword nimBuiltin OpenFile OpenFile CloseFile EndOfFile readChar
  syn keyword nimBuiltin FlushFile readfile readFile readline readLine write writeln writeLn writeline writeLine
  syn keyword nimBuiltin getfilesize getFileSize ReadBytes ReadChars readbuffer readBuffer writebytes writeBytes
  syn keyword nimBuiltin writechars writeChars writebuffer writeBuffer setfilepos setFilePos getfilepos getFilePos
  syn keyword nimBuiltin filehandle fileHandle countdown countup items lines
  syn keyword nimBuiltin FileMode File RootObj FileHandle ByteAddress Endianness
  " New (missing from og)
  syn keyword nimBuiltin byte any auto csize_t cstringArray
  syn keyword nimBuiltin newSeqWith newSeqOfCap newStringOfCap
  syn keyword nimKeyword define pragma threadvar compiletime
  syn keyword nimKeyword passC passL link importc importcpp importjs cdecl
  syn match   nimKeyword "compile:"
  syn match   nimKeyword "header:"
  syn match   nimKeyword "size:"
  syn keyword nimKeyword async await typeof align pure
  " Custom types
  syn keyword nimBuiltin i8 i16 i32 i64 u8 u16 u32 u64 f32 f64 Sz str cstr
  " MinC specials
  syn keyword nimKeyword   comptime namespace stub readonly noreturn
  syn keyword nimException calloc malloc free resize
endif

if nim_highlight_exceptions == 1
  " Builtin Defects
  syn keyword nimBuiltin   Defect ArithmeticDefect DivByZeroDefect OverflowDefect AccessViolationDefect DeadThreadDefect
  syn keyword nimBuiltin   OutOfMemDefect IndexDefect FieldDefect RangeDefect StackOverflowDefect ReraiseDefect AssertionDefect
  syn keyword nimBuiltin   ObjectAssignmentDefect ObjectConversionDefect FloatingPointDefect FloatInvalidOpDefect
  syn keyword nimBuiltin   FloatDivByZeroDefect FloatOverflowDefect FloatUnderflowDefect FloatInexactDefect NilAccessDefect
  " Builtin Errors
  syn keyword nimBuiltin   LibraryError ResourceExhaustedError
  syn keyword nimBuiltin   Exception CatchableError IOError EOFError OSError KeyError ValueError
  " Any User error possible
  syn match   nimException '[A-Z]\w*Error\>'
  syn match   nimException '[A-Z]\w*Defect\>'
endif

if nim_highlight_space_errors == 1
  " trailing whitespace
  syn match   nimSpaceError   display excludenl "\S\s\+$"ms=s+1
  " any tabs are illegal in nim
  syn match   nimSpaceError   display "\t"
endif

if nim_highlight_special_vars
  " syn keyword nimSpecialVar result
endif

syn sync match nimSync grouphere NONE "):$"
syn sync maxlines=200
syn sync minlines=2000

if v:version >= 508 || !exists('did_nim_syn_inits')
  if v:version <= 508
    let did_nim_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink nimBrackets    Operator
  HiLink nimKeyword     Keyword
  HiLink nimFunction    Function
  HiLink nimConditional Conditional
  HiLink nimRepeat      Decorator
  HiLink nimString      String
  HiLink nimRawString   String
  HiLink nimBoolean     Boolean
  HiLink nimEscape      Special
  " HiLink nimOperator    Operator
  HiLink nimOperator    Repeat
  HiLink nimPreCondit   PreCondit
  HiLink nimComment     Comment
  HiLink nimTodo        Todo
  HiLink nimDecorator   Define
  HiLink nimSpecialVar  Identifier
  " New
  HiLink nimStatement   Statement
  HiLink nimConstant    Constant
  HiLink nimInclude     Include
  HiLink nimStructure   Structure
  HiLink nimMacro       Macro
  HiLink nimCharacter   Character
  HiLink nimFloat       Float
  HiLink nimPragma      PreProc
  HiLink nimType        Keyword

  if nim_highlight_numbers == 1
    HiLink nimNumber	Number
  endif

  if nim_highlight_builtins == 1
    HiLink nimBuiltin	Number
  endif

  if nim_highlight_exceptions == 1
    HiLink nimException	Exception
  endif

  if nim_highlight_space_errors == 1
    HiLink nimSpaceError	Error
  endif

  delcommand HiLink
endif

let b:current_syntax = 'nim'

