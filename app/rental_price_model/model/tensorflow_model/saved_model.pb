ʦ
??
^
AssignVariableOp
resource
value"dtype"
dtypetype"
validate_shapebool( ?
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
N
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype"
Truncatebool( 
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
?
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool("
allow_missing_filesbool( ?

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
@
ReadVariableOp
resource
value"dtype"
dtypetype?
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
?
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring ??
@
StaticRegexFullMatch	
input

output
"
patternstring
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
?
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 ?"serve*2.10.02v2.10.0-rc3-6-g359c3cdfc5f8ޮ
^
countVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_namecount
W
count/Read/ReadVariableOpReadVariableOpcount*
_output_shapes
: *
dtype0
^
totalVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nametotal
W
total/Read/ReadVariableOpReadVariableOptotal*
_output_shapes
: *
dtype0
l
SGD/momentumVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nameSGD/momentum
e
 SGD/momentum/Read/ReadVariableOpReadVariableOpSGD/momentum*
_output_shapes
: *
dtype0
v
SGD/learning_rateVarHandleOp*
_output_shapes
: *
dtype0*
shape: *"
shared_nameSGD/learning_rate
o
%SGD/learning_rate/Read/ReadVariableOpReadVariableOpSGD/learning_rate*
_output_shapes
: *
dtype0
f
	SGD/decayVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	SGD/decay
_
SGD/decay/Read/ReadVariableOpReadVariableOp	SGD/decay*
_output_shapes
: *
dtype0
d
SGD/iterVarHandleOp*
_output_shapes
: *
dtype0	*
shape: *
shared_name
SGD/iter
]
SGD/iter/Read/ReadVariableOpReadVariableOpSGD/iter*
_output_shapes
: *
dtype0	
n
output/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_nameoutput/bias
g
output/bias/Read/ReadVariableOpReadVariableOpoutput/bias*
_output_shapes
:*
dtype0
v
output/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
: *
shared_nameoutput/kernel
o
!output/kernel/Read/ReadVariableOpReadVariableOpoutput/kernel*
_output_shapes

: *
dtype0
p
hidden2/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_namehidden2/bias
i
 hidden2/bias/Read/ReadVariableOpReadVariableOphidden2/bias*
_output_shapes
: *
dtype0
x
hidden2/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:  *
shared_namehidden2/kernel
q
"hidden2/kernel/Read/ReadVariableOpReadVariableOphidden2/kernel*
_output_shapes

:  *
dtype0
p
hidden1/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_namehidden1/bias
i
 hidden1/bias/Read/ReadVariableOpReadVariableOphidden1/bias*
_output_shapes
: *
dtype0
x
hidden1/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:7 *
shared_namehidden1/kernel
q
"hidden1/kernel/Read/ReadVariableOpReadVariableOphidden1/kernel*
_output_shapes

:7 *
dtype0
?
serving_default_hidden1_inputPlaceholder*'
_output_shapes
:?????????7*
dtype0*
shape:?????????7
?
StatefulPartitionedCallStatefulPartitionedCallserving_default_hidden1_inputhidden1/kernelhidden1/biashidden2/kernelhidden2/biasoutput/kerneloutput/bias*
Tin
	2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8? *-
f(R&
$__inference_signature_wrapper_252100

NoOpNoOp
?
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*?
value?B? B?
?
layer_with_weights-0
layer-0
layer_with_weights-1
layer-1
layer_with_weights-2
layer-2
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*	&call_and_return_all_conditional_losses

_default_save_signature
	optimizer

signatures*
?
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses

kernel
bias*
?
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses

kernel
bias*
?
	variables
trainable_variables
regularization_losses
 	keras_api
!__call__
*"&call_and_return_all_conditional_losses

#kernel
$bias*
.
0
1
2
3
#4
$5*
.
0
1
2
3
#4
$5*
* 
?
%non_trainable_variables

&layers
'metrics
(layer_regularization_losses
)layer_metrics
	variables
trainable_variables
regularization_losses
__call__

_default_save_signature
*	&call_and_return_all_conditional_losses
&	"call_and_return_conditional_losses*
6
*trace_0
+trace_1
,trace_2
-trace_3* 
6
.trace_0
/trace_1
0trace_2
1trace_3* 
* 
:
2iter
	3decay
4learning_rate
5momentum*

6serving_default* 

0
1*

0
1*
* 
?
7non_trainable_variables

8layers
9metrics
:layer_regularization_losses
;layer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses*

<trace_0* 

=trace_0* 
^X
VARIABLE_VALUEhidden1/kernel6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUE*
ZT
VARIABLE_VALUEhidden1/bias4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUE*

0
1*

0
1*
* 
?
>non_trainable_variables

?layers
@metrics
Alayer_regularization_losses
Blayer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses*

Ctrace_0* 

Dtrace_0* 
^X
VARIABLE_VALUEhidden2/kernel6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUE*
ZT
VARIABLE_VALUEhidden2/bias4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUE*

#0
$1*

#0
$1*
* 
?
Enon_trainable_variables

Flayers
Gmetrics
Hlayer_regularization_losses
Ilayer_metrics
	variables
trainable_variables
regularization_losses
!__call__
*"&call_and_return_all_conditional_losses
&""call_and_return_conditional_losses*

Jtrace_0* 

Ktrace_0* 
]W
VARIABLE_VALUEoutput/kernel6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUE*
YS
VARIABLE_VALUEoutput/bias4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUE*
* 

0
1
2*

L0*
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
KE
VARIABLE_VALUESGD/iter)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUE*
MG
VARIABLE_VALUE	SGD/decay*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUE*
]W
VARIABLE_VALUESGD/learning_rate2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUE*
SM
VARIABLE_VALUESGD/momentum-optimizer/momentum/.ATTRIBUTES/VARIABLE_VALUE*
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
8
M	variables
N	keras_api
	Ototal
	Pcount*

O0
P1*

M	variables*
SM
VARIABLE_VALUEtotal4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUE*
SM
VARIABLE_VALUEcount4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUE*
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
?
StatefulPartitionedCall_1StatefulPartitionedCallsaver_filename"hidden1/kernel/Read/ReadVariableOp hidden1/bias/Read/ReadVariableOp"hidden2/kernel/Read/ReadVariableOp hidden2/bias/Read/ReadVariableOp!output/kernel/Read/ReadVariableOpoutput/bias/Read/ReadVariableOpSGD/iter/Read/ReadVariableOpSGD/decay/Read/ReadVariableOp%SGD/learning_rate/Read/ReadVariableOp SGD/momentum/Read/ReadVariableOptotal/Read/ReadVariableOpcount/Read/ReadVariableOpConst*
Tin
2	*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *(
f#R!
__inference__traced_save_252296
?
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filenamehidden1/kernelhidden1/biashidden2/kernelhidden2/biasoutput/kerneloutput/biasSGD/iter	SGD/decaySGD/learning_rateSGD/momentumtotalcount*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *+
f&R$
"__inference__traced_restore_252342??
?	
?
+__inference_sequential_layer_call_fn_252037
hidden1_input
unknown:7 
	unknown_0: 
	unknown_1:  
	unknown_2: 
	unknown_3: 
	unknown_4:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallhidden1_inputunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8? *O
fJRH
F__inference_sequential_layer_call_and_return_conditional_losses_252005o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????7: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:V R
'
_output_shapes
:?????????7
'
_user_specified_namehidden1_input
?
?
F__inference_sequential_layer_call_and_return_conditional_losses_252005

inputs 
hidden1_251989:7 
hidden1_251991:  
hidden2_251994:  
hidden2_251996: 
output_251999: 
output_252001:
identity??hidden1/StatefulPartitionedCall?hidden2/StatefulPartitionedCall?output/StatefulPartitionedCall]
hidden1/CastCastinputs*

DstT0*

SrcT0*'
_output_shapes
:?????????7?
hidden1/StatefulPartitionedCallStatefulPartitionedCallhidden1/Cast:y:0hidden1_251989hidden1_251991*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:????????? *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *L
fGRE
C__inference_hidden1_layer_call_and_return_conditional_losses_251882?
hidden2/StatefulPartitionedCallStatefulPartitionedCall(hidden1/StatefulPartitionedCall:output:0hidden2_251994hidden2_251996*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:????????? *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *L
fGRE
C__inference_hidden2_layer_call_and_return_conditional_losses_251898?
output/StatefulPartitionedCallStatefulPartitionedCall(hidden2/StatefulPartitionedCall:output:0output_251999output_252001*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *K
fFRD
B__inference_output_layer_call_and_return_conditional_losses_251914v
IdentityIdentity'output/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp ^hidden1/StatefulPartitionedCall ^hidden2/StatefulPartitionedCall^output/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????7: : : : : : 2B
hidden1/StatefulPartitionedCallhidden1/StatefulPartitionedCall2B
hidden2/StatefulPartitionedCallhidden2/StatefulPartitionedCall2@
output/StatefulPartitionedCalloutput/StatefulPartitionedCall:O K
'
_output_shapes
:?????????7
 
_user_specified_nameinputs
?
?
+__inference_sequential_layer_call_fn_252134

inputs
unknown:7 
	unknown_0: 
	unknown_1:  
	unknown_2: 
	unknown_3: 
	unknown_4:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8? *O
fJRH
F__inference_sequential_layer_call_and_return_conditional_losses_252005o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????7: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????7
 
_user_specified_nameinputs
?	
?
B__inference_output_layer_call_and_return_conditional_losses_251914

inputs0
matmul_readvariableop_resource: -
biasadd_readvariableop_resource:
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

: *
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????_
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:????????? : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:????????? 
 
_user_specified_nameinputs
?
?
$__inference_signature_wrapper_252100
hidden1_input
unknown:7 
	unknown_0: 
	unknown_1:  
	unknown_2: 
	unknown_3: 
	unknown_4:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallhidden1_inputunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8? **
f%R#
!__inference__wrapped_model_251864o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????7: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:V R
'
_output_shapes
:?????????7
'
_user_specified_namehidden1_input
?
?
!__inference__wrapped_model_251864
hidden1_inputC
1sequential_hidden1_matmul_readvariableop_resource:7 @
2sequential_hidden1_biasadd_readvariableop_resource: C
1sequential_hidden2_matmul_readvariableop_resource:  @
2sequential_hidden2_biasadd_readvariableop_resource: B
0sequential_output_matmul_readvariableop_resource: ?
1sequential_output_biasadd_readvariableop_resource:
identity??)sequential/hidden1/BiasAdd/ReadVariableOp?(sequential/hidden1/MatMul/ReadVariableOp?)sequential/hidden2/BiasAdd/ReadVariableOp?(sequential/hidden2/MatMul/ReadVariableOp?(sequential/output/BiasAdd/ReadVariableOp?'sequential/output/MatMul/ReadVariableOpo
sequential/hidden1/CastCasthidden1_input*

DstT0*

SrcT0*'
_output_shapes
:?????????7?
(sequential/hidden1/MatMul/ReadVariableOpReadVariableOp1sequential_hidden1_matmul_readvariableop_resource*
_output_shapes

:7 *
dtype0?
sequential/hidden1/MatMulMatMulsequential/hidden1/Cast:y:00sequential/hidden1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? ?
)sequential/hidden1/BiasAdd/ReadVariableOpReadVariableOp2sequential_hidden1_biasadd_readvariableop_resource*
_output_shapes
: *
dtype0?
sequential/hidden1/BiasAddBiasAdd#sequential/hidden1/MatMul:product:01sequential/hidden1/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? ?
(sequential/hidden2/MatMul/ReadVariableOpReadVariableOp1sequential_hidden2_matmul_readvariableop_resource*
_output_shapes

:  *
dtype0?
sequential/hidden2/MatMulMatMul#sequential/hidden1/BiasAdd:output:00sequential/hidden2/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? ?
)sequential/hidden2/BiasAdd/ReadVariableOpReadVariableOp2sequential_hidden2_biasadd_readvariableop_resource*
_output_shapes
: *
dtype0?
sequential/hidden2/BiasAddBiasAdd#sequential/hidden2/MatMul:product:01sequential/hidden2/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? ?
'sequential/output/MatMul/ReadVariableOpReadVariableOp0sequential_output_matmul_readvariableop_resource*
_output_shapes

: *
dtype0?
sequential/output/MatMulMatMul#sequential/hidden2/BiasAdd:output:0/sequential/output/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
(sequential/output/BiasAdd/ReadVariableOpReadVariableOp1sequential_output_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0?
sequential/output/BiasAddBiasAdd"sequential/output/MatMul:product:00sequential/output/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????q
IdentityIdentity"sequential/output/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp*^sequential/hidden1/BiasAdd/ReadVariableOp)^sequential/hidden1/MatMul/ReadVariableOp*^sequential/hidden2/BiasAdd/ReadVariableOp)^sequential/hidden2/MatMul/ReadVariableOp)^sequential/output/BiasAdd/ReadVariableOp(^sequential/output/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????7: : : : : : 2V
)sequential/hidden1/BiasAdd/ReadVariableOp)sequential/hidden1/BiasAdd/ReadVariableOp2T
(sequential/hidden1/MatMul/ReadVariableOp(sequential/hidden1/MatMul/ReadVariableOp2V
)sequential/hidden2/BiasAdd/ReadVariableOp)sequential/hidden2/BiasAdd/ReadVariableOp2T
(sequential/hidden2/MatMul/ReadVariableOp(sequential/hidden2/MatMul/ReadVariableOp2T
(sequential/output/BiasAdd/ReadVariableOp(sequential/output/BiasAdd/ReadVariableOp2R
'sequential/output/MatMul/ReadVariableOp'sequential/output/MatMul/ReadVariableOp:V R
'
_output_shapes
:?????????7
'
_user_specified_namehidden1_input
?
?
+__inference_sequential_layer_call_fn_252117

inputs
unknown:7 
	unknown_0: 
	unknown_1:  
	unknown_2: 
	unknown_3: 
	unknown_4:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8? *O
fJRH
F__inference_sequential_layer_call_and_return_conditional_losses_251921o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????7: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????7
 
_user_specified_nameinputs
?
?
'__inference_output_layer_call_fn_252227

inputs
unknown: 
	unknown_0:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *K
fFRD
B__inference_output_layer_call_and_return_conditional_losses_251914o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:????????? : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:????????? 
 
_user_specified_nameinputs
?
?
F__inference_sequential_layer_call_and_return_conditional_losses_252077
hidden1_input 
hidden1_252061:7 
hidden1_252063:  
hidden2_252066:  
hidden2_252068: 
output_252071: 
output_252073:
identity??hidden1/StatefulPartitionedCall?hidden2/StatefulPartitionedCall?output/StatefulPartitionedCalld
hidden1/CastCasthidden1_input*

DstT0*

SrcT0*'
_output_shapes
:?????????7?
hidden1/StatefulPartitionedCallStatefulPartitionedCallhidden1/Cast:y:0hidden1_252061hidden1_252063*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:????????? *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *L
fGRE
C__inference_hidden1_layer_call_and_return_conditional_losses_251882?
hidden2/StatefulPartitionedCallStatefulPartitionedCall(hidden1/StatefulPartitionedCall:output:0hidden2_252066hidden2_252068*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:????????? *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *L
fGRE
C__inference_hidden2_layer_call_and_return_conditional_losses_251898?
output/StatefulPartitionedCallStatefulPartitionedCall(hidden2/StatefulPartitionedCall:output:0output_252071output_252073*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *K
fFRD
B__inference_output_layer_call_and_return_conditional_losses_251914v
IdentityIdentity'output/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp ^hidden1/StatefulPartitionedCall ^hidden2/StatefulPartitionedCall^output/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????7: : : : : : 2B
hidden1/StatefulPartitionedCallhidden1/StatefulPartitionedCall2B
hidden2/StatefulPartitionedCallhidden2/StatefulPartitionedCall2@
output/StatefulPartitionedCalloutput/StatefulPartitionedCall:V R
'
_output_shapes
:?????????7
'
_user_specified_namehidden1_input
?	
?
C__inference_hidden2_layer_call_and_return_conditional_losses_251898

inputs0
matmul_readvariableop_resource:  -
biasadd_readvariableop_resource: 
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:  *
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
: *
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? _
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:????????? w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:????????? : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:????????? 
 
_user_specified_nameinputs
?1
?
"__inference__traced_restore_252342
file_prefix1
assignvariableop_hidden1_kernel:7 -
assignvariableop_1_hidden1_bias: 3
!assignvariableop_2_hidden2_kernel:  -
assignvariableop_3_hidden2_bias: 2
 assignvariableop_4_output_kernel: ,
assignvariableop_5_output_bias:%
assignvariableop_6_sgd_iter:	 &
assignvariableop_7_sgd_decay: .
$assignvariableop_8_sgd_learning_rate: )
assignvariableop_9_sgd_momentum: #
assignvariableop_10_total: #
assignvariableop_11_count: 
identity_13??AssignVariableOp?AssignVariableOp_1?AssignVariableOp_10?AssignVariableOp_11?AssignVariableOp_2?AssignVariableOp_3?AssignVariableOp_4?AssignVariableOp_5?AssignVariableOp_6?AssignVariableOp_7?AssignVariableOp_8?AssignVariableOp_9?
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*?
value?B?B6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB-optimizer/momentum/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH?
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*-
value$B"B B B B B B B B B B B B B ?
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*H
_output_shapes6
4:::::::::::::*
dtypes
2	[
IdentityIdentityRestoreV2:tensors:0"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOpAssignVariableOpassignvariableop_hidden1_kernelIdentity:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_1AssignVariableOpassignvariableop_1_hidden1_biasIdentity_1:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_2IdentityRestoreV2:tensors:2"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_2AssignVariableOp!assignvariableop_2_hidden2_kernelIdentity_2:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_3IdentityRestoreV2:tensors:3"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_3AssignVariableOpassignvariableop_3_hidden2_biasIdentity_3:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_4IdentityRestoreV2:tensors:4"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_4AssignVariableOp assignvariableop_4_output_kernelIdentity_4:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_5IdentityRestoreV2:tensors:5"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_5AssignVariableOpassignvariableop_5_output_biasIdentity_5:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_6IdentityRestoreV2:tensors:6"/device:CPU:0*
T0	*
_output_shapes
:?
AssignVariableOp_6AssignVariableOpassignvariableop_6_sgd_iterIdentity_6:output:0"/device:CPU:0*
_output_shapes
 *
dtype0	]

Identity_7IdentityRestoreV2:tensors:7"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_7AssignVariableOpassignvariableop_7_sgd_decayIdentity_7:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_8IdentityRestoreV2:tensors:8"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_8AssignVariableOp$assignvariableop_8_sgd_learning_rateIdentity_8:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_9IdentityRestoreV2:tensors:9"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_9AssignVariableOpassignvariableop_9_sgd_momentumIdentity_9:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_10IdentityRestoreV2:tensors:10"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_10AssignVariableOpassignvariableop_10_totalIdentity_10:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_11IdentityRestoreV2:tensors:11"/device:CPU:0*
T0*
_output_shapes
:?
AssignVariableOp_11AssignVariableOpassignvariableop_11_countIdentity_11:output:0"/device:CPU:0*
_output_shapes
 *
dtype01
NoOpNoOp"/device:CPU:0*
_output_shapes
 ?
Identity_12Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_2^AssignVariableOp_3^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9^NoOp"/device:CPU:0*
T0*
_output_shapes
: W
Identity_13IdentityIdentity_12:output:0^NoOp_1*
T0*
_output_shapes
: ?
NoOp_1NoOp^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_2^AssignVariableOp_3^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9*"
_acd_function_control_output(*
_output_shapes
 "#
identity_13Identity_13:output:0*-
_input_shapes
: : : : : : : : : : : : : 2$
AssignVariableOpAssignVariableOp2(
AssignVariableOp_1AssignVariableOp_12*
AssignVariableOp_10AssignVariableOp_102*
AssignVariableOp_11AssignVariableOp_112(
AssignVariableOp_2AssignVariableOp_22(
AssignVariableOp_3AssignVariableOp_32(
AssignVariableOp_4AssignVariableOp_42(
AssignVariableOp_5AssignVariableOp_52(
AssignVariableOp_6AssignVariableOp_62(
AssignVariableOp_7AssignVariableOp_72(
AssignVariableOp_8AssignVariableOp_82(
AssignVariableOp_9AssignVariableOp_9:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix
?!
?
__inference__traced_save_252296
file_prefix-
)savev2_hidden1_kernel_read_readvariableop+
'savev2_hidden1_bias_read_readvariableop-
)savev2_hidden2_kernel_read_readvariableop+
'savev2_hidden2_bias_read_readvariableop,
(savev2_output_kernel_read_readvariableop*
&savev2_output_bias_read_readvariableop'
#savev2_sgd_iter_read_readvariableop	(
$savev2_sgd_decay_read_readvariableop0
,savev2_sgd_learning_rate_read_readvariableop+
'savev2_sgd_momentum_read_readvariableop$
 savev2_total_read_readvariableop$
 savev2_count_read_readvariableop
savev2_const

identity_1??MergeV2Checkpointsw
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*Z
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.parta
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part?
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: f

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: L

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :f
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : ?
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: ?
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*?
value?B?B6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB-optimizer/momentum/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH?
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*-
value$B"B B B B B B B B B B B B B ?
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0)savev2_hidden1_kernel_read_readvariableop'savev2_hidden1_bias_read_readvariableop)savev2_hidden2_kernel_read_readvariableop'savev2_hidden2_bias_read_readvariableop(savev2_output_kernel_read_readvariableop&savev2_output_bias_read_readvariableop#savev2_sgd_iter_read_readvariableop$savev2_sgd_decay_read_readvariableop,savev2_sgd_learning_rate_read_readvariableop'savev2_sgd_momentum_read_readvariableop savev2_total_read_readvariableop savev2_count_read_readvariableopsavev2_const"/device:CPU:0*
_output_shapes
 *
dtypes
2	?
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:?
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 f
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: Q

Identity_1IdentityIdentity:output:0^NoOp*
T0*
_output_shapes
: [
NoOpNoOp^MergeV2Checkpoints*"
_acd_function_control_output(*
_output_shapes
 "!

identity_1Identity_1:output:0*S
_input_shapesB
@: :7 : :  : : :: : : : : : : 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:$ 

_output_shapes

:7 : 

_output_shapes
: :$ 

_output_shapes

:  : 

_output_shapes
: :$ 

_output_shapes

: : 

_output_shapes
::

_output_shapes
: :

_output_shapes
: :	

_output_shapes
: :


_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: 
?
?
(__inference_hidden1_layer_call_fn_252189

inputs
unknown:7 
	unknown_0: 
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:????????? *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *L
fGRE
C__inference_hidden1_layer_call_and_return_conditional_losses_251882o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:????????? `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????7: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:?????????7
 
_user_specified_nameinputs
?
?
F__inference_sequential_layer_call_and_return_conditional_losses_252180

inputs8
&hidden1_matmul_readvariableop_resource:7 5
'hidden1_biasadd_readvariableop_resource: 8
&hidden2_matmul_readvariableop_resource:  5
'hidden2_biasadd_readvariableop_resource: 7
%output_matmul_readvariableop_resource: 4
&output_biasadd_readvariableop_resource:
identity??hidden1/BiasAdd/ReadVariableOp?hidden1/MatMul/ReadVariableOp?hidden2/BiasAdd/ReadVariableOp?hidden2/MatMul/ReadVariableOp?output/BiasAdd/ReadVariableOp?output/MatMul/ReadVariableOp]
hidden1/CastCastinputs*

DstT0*

SrcT0*'
_output_shapes
:?????????7?
hidden1/MatMul/ReadVariableOpReadVariableOp&hidden1_matmul_readvariableop_resource*
_output_shapes

:7 *
dtype0?
hidden1/MatMulMatMulhidden1/Cast:y:0%hidden1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? ?
hidden1/BiasAdd/ReadVariableOpReadVariableOp'hidden1_biasadd_readvariableop_resource*
_output_shapes
: *
dtype0?
hidden1/BiasAddBiasAddhidden1/MatMul:product:0&hidden1/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? ?
hidden2/MatMul/ReadVariableOpReadVariableOp&hidden2_matmul_readvariableop_resource*
_output_shapes

:  *
dtype0?
hidden2/MatMulMatMulhidden1/BiasAdd:output:0%hidden2/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? ?
hidden2/BiasAdd/ReadVariableOpReadVariableOp'hidden2_biasadd_readvariableop_resource*
_output_shapes
: *
dtype0?
hidden2/BiasAddBiasAddhidden2/MatMul:product:0&hidden2/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? ?
output/MatMul/ReadVariableOpReadVariableOp%output_matmul_readvariableop_resource*
_output_shapes

: *
dtype0?
output/MatMulMatMulhidden2/BiasAdd:output:0$output/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
output/BiasAdd/ReadVariableOpReadVariableOp&output_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0?
output/BiasAddBiasAddoutput/MatMul:product:0%output/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????f
IdentityIdentityoutput/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp^hidden1/BiasAdd/ReadVariableOp^hidden1/MatMul/ReadVariableOp^hidden2/BiasAdd/ReadVariableOp^hidden2/MatMul/ReadVariableOp^output/BiasAdd/ReadVariableOp^output/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????7: : : : : : 2@
hidden1/BiasAdd/ReadVariableOphidden1/BiasAdd/ReadVariableOp2>
hidden1/MatMul/ReadVariableOphidden1/MatMul/ReadVariableOp2@
hidden2/BiasAdd/ReadVariableOphidden2/BiasAdd/ReadVariableOp2>
hidden2/MatMul/ReadVariableOphidden2/MatMul/ReadVariableOp2>
output/BiasAdd/ReadVariableOpoutput/BiasAdd/ReadVariableOp2<
output/MatMul/ReadVariableOpoutput/MatMul/ReadVariableOp:O K
'
_output_shapes
:?????????7
 
_user_specified_nameinputs
?	
?
C__inference_hidden2_layer_call_and_return_conditional_losses_252218

inputs0
matmul_readvariableop_resource:  -
biasadd_readvariableop_resource: 
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:  *
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
: *
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? _
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:????????? w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:????????? : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:????????? 
 
_user_specified_nameinputs
?
?
(__inference_hidden2_layer_call_fn_252208

inputs
unknown:  
	unknown_0: 
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:????????? *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *L
fGRE
C__inference_hidden2_layer_call_and_return_conditional_losses_251898o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:????????? `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:????????? : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:????????? 
 
_user_specified_nameinputs
?	
?
C__inference_hidden1_layer_call_and_return_conditional_losses_251882

inputs0
matmul_readvariableop_resource:7 -
biasadd_readvariableop_resource: 
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:7 *
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
: *
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? _
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:????????? w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????7: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????7
 
_user_specified_nameinputs
?
?
F__inference_sequential_layer_call_and_return_conditional_losses_252057
hidden1_input 
hidden1_252041:7 
hidden1_252043:  
hidden2_252046:  
hidden2_252048: 
output_252051: 
output_252053:
identity??hidden1/StatefulPartitionedCall?hidden2/StatefulPartitionedCall?output/StatefulPartitionedCalld
hidden1/CastCasthidden1_input*

DstT0*

SrcT0*'
_output_shapes
:?????????7?
hidden1/StatefulPartitionedCallStatefulPartitionedCallhidden1/Cast:y:0hidden1_252041hidden1_252043*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:????????? *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *L
fGRE
C__inference_hidden1_layer_call_and_return_conditional_losses_251882?
hidden2/StatefulPartitionedCallStatefulPartitionedCall(hidden1/StatefulPartitionedCall:output:0hidden2_252046hidden2_252048*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:????????? *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *L
fGRE
C__inference_hidden2_layer_call_and_return_conditional_losses_251898?
output/StatefulPartitionedCallStatefulPartitionedCall(hidden2/StatefulPartitionedCall:output:0output_252051output_252053*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *K
fFRD
B__inference_output_layer_call_and_return_conditional_losses_251914v
IdentityIdentity'output/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp ^hidden1/StatefulPartitionedCall ^hidden2/StatefulPartitionedCall^output/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????7: : : : : : 2B
hidden1/StatefulPartitionedCallhidden1/StatefulPartitionedCall2B
hidden2/StatefulPartitionedCallhidden2/StatefulPartitionedCall2@
output/StatefulPartitionedCalloutput/StatefulPartitionedCall:V R
'
_output_shapes
:?????????7
'
_user_specified_namehidden1_input
?	
?
C__inference_hidden1_layer_call_and_return_conditional_losses_252199

inputs0
matmul_readvariableop_resource:7 -
biasadd_readvariableop_resource: 
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:7 *
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
: *
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? _
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:????????? w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:?????????7: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:?????????7
 
_user_specified_nameinputs
?
?
F__inference_sequential_layer_call_and_return_conditional_losses_251921

inputs 
hidden1_251883:7 
hidden1_251885:  
hidden2_251899:  
hidden2_251901: 
output_251915: 
output_251917:
identity??hidden1/StatefulPartitionedCall?hidden2/StatefulPartitionedCall?output/StatefulPartitionedCall]
hidden1/CastCastinputs*

DstT0*

SrcT0*'
_output_shapes
:?????????7?
hidden1/StatefulPartitionedCallStatefulPartitionedCallhidden1/Cast:y:0hidden1_251883hidden1_251885*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:????????? *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *L
fGRE
C__inference_hidden1_layer_call_and_return_conditional_losses_251882?
hidden2/StatefulPartitionedCallStatefulPartitionedCall(hidden1/StatefulPartitionedCall:output:0hidden2_251899hidden2_251901*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:????????? *$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *L
fGRE
C__inference_hidden2_layer_call_and_return_conditional_losses_251898?
output/StatefulPartitionedCallStatefulPartitionedCall(hidden2/StatefulPartitionedCall:output:0output_251915output_251917*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8? *K
fFRD
B__inference_output_layer_call_and_return_conditional_losses_251914v
IdentityIdentity'output/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp ^hidden1/StatefulPartitionedCall ^hidden2/StatefulPartitionedCall^output/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????7: : : : : : 2B
hidden1/StatefulPartitionedCallhidden1/StatefulPartitionedCall2B
hidden2/StatefulPartitionedCallhidden2/StatefulPartitionedCall2@
output/StatefulPartitionedCalloutput/StatefulPartitionedCall:O K
'
_output_shapes
:?????????7
 
_user_specified_nameinputs
?	
?
+__inference_sequential_layer_call_fn_251936
hidden1_input
unknown:7 
	unknown_0: 
	unknown_1:  
	unknown_2: 
	unknown_3: 
	unknown_4:
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallhidden1_inputunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8? *O
fJRH
F__inference_sequential_layer_call_and_return_conditional_losses_251921o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:?????????`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????7: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:V R
'
_output_shapes
:?????????7
'
_user_specified_namehidden1_input
?	
?
B__inference_output_layer_call_and_return_conditional_losses_252237

inputs0
matmul_readvariableop_resource: -
biasadd_readvariableop_resource:
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

: *
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????_
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:?????????w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:????????? : : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:????????? 
 
_user_specified_nameinputs
?
?
F__inference_sequential_layer_call_and_return_conditional_losses_252157

inputs8
&hidden1_matmul_readvariableop_resource:7 5
'hidden1_biasadd_readvariableop_resource: 8
&hidden2_matmul_readvariableop_resource:  5
'hidden2_biasadd_readvariableop_resource: 7
%output_matmul_readvariableop_resource: 4
&output_biasadd_readvariableop_resource:
identity??hidden1/BiasAdd/ReadVariableOp?hidden1/MatMul/ReadVariableOp?hidden2/BiasAdd/ReadVariableOp?hidden2/MatMul/ReadVariableOp?output/BiasAdd/ReadVariableOp?output/MatMul/ReadVariableOp]
hidden1/CastCastinputs*

DstT0*

SrcT0*'
_output_shapes
:?????????7?
hidden1/MatMul/ReadVariableOpReadVariableOp&hidden1_matmul_readvariableop_resource*
_output_shapes

:7 *
dtype0?
hidden1/MatMulMatMulhidden1/Cast:y:0%hidden1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? ?
hidden1/BiasAdd/ReadVariableOpReadVariableOp'hidden1_biasadd_readvariableop_resource*
_output_shapes
: *
dtype0?
hidden1/BiasAddBiasAddhidden1/MatMul:product:0&hidden1/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? ?
hidden2/MatMul/ReadVariableOpReadVariableOp&hidden2_matmul_readvariableop_resource*
_output_shapes

:  *
dtype0?
hidden2/MatMulMatMulhidden1/BiasAdd:output:0%hidden2/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? ?
hidden2/BiasAdd/ReadVariableOpReadVariableOp'hidden2_biasadd_readvariableop_resource*
_output_shapes
: *
dtype0?
hidden2/BiasAddBiasAddhidden2/MatMul:product:0&hidden2/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:????????? ?
output/MatMul/ReadVariableOpReadVariableOp%output_matmul_readvariableop_resource*
_output_shapes

: *
dtype0?
output/MatMulMatMulhidden2/BiasAdd:output:0$output/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
output/BiasAdd/ReadVariableOpReadVariableOp&output_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0?
output/BiasAddBiasAddoutput/MatMul:product:0%output/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????f
IdentityIdentityoutput/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:??????????
NoOpNoOp^hidden1/BiasAdd/ReadVariableOp^hidden1/MatMul/ReadVariableOp^hidden2/BiasAdd/ReadVariableOp^hidden2/MatMul/ReadVariableOp^output/BiasAdd/ReadVariableOp^output/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:?????????7: : : : : : 2@
hidden1/BiasAdd/ReadVariableOphidden1/BiasAdd/ReadVariableOp2>
hidden1/MatMul/ReadVariableOphidden1/MatMul/ReadVariableOp2@
hidden2/BiasAdd/ReadVariableOphidden2/BiasAdd/ReadVariableOp2>
hidden2/MatMul/ReadVariableOphidden2/MatMul/ReadVariableOp2>
output/BiasAdd/ReadVariableOpoutput/BiasAdd/ReadVariableOp2<
output/MatMul/ReadVariableOpoutput/MatMul/ReadVariableOp:O K
'
_output_shapes
:?????????7
 
_user_specified_nameinputs"?	L
saver_filename:0StatefulPartitionedCall_1:0StatefulPartitionedCall_28"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*?
serving_default?
G
hidden1_input6
serving_default_hidden1_input:0?????????7:
output0
StatefulPartitionedCall:0?????????tensorflow/serving/predict:?f
?
layer_with_weights-0
layer-0
layer_with_weights-1
layer-1
layer_with_weights-2
layer-2
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*	&call_and_return_all_conditional_losses

_default_save_signature
	optimizer

signatures"
_tf_keras_sequential
?
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses

kernel
bias"
_tf_keras_layer
?
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses

kernel
bias"
_tf_keras_layer
?
	variables
trainable_variables
regularization_losses
 	keras_api
!__call__
*"&call_and_return_all_conditional_losses

#kernel
$bias"
_tf_keras_layer
J
0
1
2
3
#4
$5"
trackable_list_wrapper
J
0
1
2
3
#4
$5"
trackable_list_wrapper
 "
trackable_list_wrapper
?
%non_trainable_variables

&layers
'metrics
(layer_regularization_losses
)layer_metrics
	variables
trainable_variables
regularization_losses
__call__

_default_save_signature
*	&call_and_return_all_conditional_losses
&	"call_and_return_conditional_losses"
_generic_user_object
?
*trace_0
+trace_1
,trace_2
-trace_32?
+__inference_sequential_layer_call_fn_251936
+__inference_sequential_layer_call_fn_252117
+__inference_sequential_layer_call_fn_252134
+__inference_sequential_layer_call_fn_252037?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 z*trace_0z+trace_1z,trace_2z-trace_3
?
.trace_0
/trace_1
0trace_2
1trace_32?
F__inference_sequential_layer_call_and_return_conditional_losses_252157
F__inference_sequential_layer_call_and_return_conditional_losses_252180
F__inference_sequential_layer_call_and_return_conditional_losses_252057
F__inference_sequential_layer_call_and_return_conditional_losses_252077?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 z.trace_0z/trace_1z0trace_2z1trace_3
?B?
!__inference__wrapped_model_251864hidden1_input"?
???
FullArgSpec
args? 
varargsjargs
varkwjkwargs
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
I
2iter
	3decay
4learning_rate
5momentum"
	optimizer
,
6serving_default"
signature_map
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
7non_trainable_variables

8layers
9metrics
:layer_regularization_losses
;layer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
?
<trace_02?
(__inference_hidden1_layer_call_fn_252189?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 z<trace_0
?
=trace_02?
C__inference_hidden1_layer_call_and_return_conditional_losses_252199?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 z=trace_0
 :7 2hidden1/kernel
: 2hidden1/bias
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
>non_trainable_variables

?layers
@metrics
Alayer_regularization_losses
Blayer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
?
Ctrace_02?
(__inference_hidden2_layer_call_fn_252208?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 zCtrace_0
?
Dtrace_02?
C__inference_hidden2_layer_call_and_return_conditional_losses_252218?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 zDtrace_0
 :  2hidden2/kernel
: 2hidden2/bias
.
#0
$1"
trackable_list_wrapper
.
#0
$1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
Enon_trainable_variables

Flayers
Gmetrics
Hlayer_regularization_losses
Ilayer_metrics
	variables
trainable_variables
regularization_losses
!__call__
*"&call_and_return_all_conditional_losses
&""call_and_return_conditional_losses"
_generic_user_object
?
Jtrace_02?
'__inference_output_layer_call_fn_252227?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 zJtrace_0
?
Ktrace_02?
B__inference_output_layer_call_and_return_conditional_losses_252237?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 zKtrace_0
: 2output/kernel
:2output/bias
 "
trackable_list_wrapper
5
0
1
2"
trackable_list_wrapper
'
L0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
?B?
+__inference_sequential_layer_call_fn_251936hidden1_input"?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?B?
+__inference_sequential_layer_call_fn_252117inputs"?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?B?
+__inference_sequential_layer_call_fn_252134inputs"?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?B?
+__inference_sequential_layer_call_fn_252037hidden1_input"?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?B?
F__inference_sequential_layer_call_and_return_conditional_losses_252157inputs"?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?B?
F__inference_sequential_layer_call_and_return_conditional_losses_252180inputs"?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?B?
F__inference_sequential_layer_call_and_return_conditional_losses_252057hidden1_input"?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?B?
F__inference_sequential_layer_call_and_return_conditional_losses_252077hidden1_input"?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
:	 (2SGD/iter
: (2	SGD/decay
: (2SGD/learning_rate
: (2SGD/momentum
?B?
$__inference_signature_wrapper_252100hidden1_input"?
???
FullArgSpec
args? 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
?B?
(__inference_hidden1_layer_call_fn_252189inputs"?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?B?
C__inference_hidden1_layer_call_and_return_conditional_losses_252199inputs"?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
?B?
(__inference_hidden2_layer_call_fn_252208inputs"?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?B?
C__inference_hidden2_layer_call_and_return_conditional_losses_252218inputs"?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
?B?
'__inference_output_layer_call_fn_252227inputs"?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?B?
B__inference_output_layer_call_and_return_conditional_losses_252237inputs"?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
N
M	variables
N	keras_api
	Ototal
	Pcount"
_tf_keras_metric
.
O0
P1"
trackable_list_wrapper
-
M	variables"
_generic_user_object
:  (2total
:  (2count?
!__inference__wrapped_model_251864q#$6?3
,?)
'?$
hidden1_input?????????7
? "/?,
*
output ?
output??????????
C__inference_hidden1_layer_call_and_return_conditional_losses_252199\/?,
%?"
 ?
inputs?????????7
? "%?"
?
0????????? 
? {
(__inference_hidden1_layer_call_fn_252189O/?,
%?"
 ?
inputs?????????7
? "?????????? ?
C__inference_hidden2_layer_call_and_return_conditional_losses_252218\/?,
%?"
 ?
inputs????????? 
? "%?"
?
0????????? 
? {
(__inference_hidden2_layer_call_fn_252208O/?,
%?"
 ?
inputs????????? 
? "?????????? ?
B__inference_output_layer_call_and_return_conditional_losses_252237\#$/?,
%?"
 ?
inputs????????? 
? "%?"
?
0?????????
? z
'__inference_output_layer_call_fn_252227O#$/?,
%?"
 ?
inputs????????? 
? "???????????
F__inference_sequential_layer_call_and_return_conditional_losses_252057o#$>?;
4?1
'?$
hidden1_input?????????7
p 

 
? "%?"
?
0?????????
? ?
F__inference_sequential_layer_call_and_return_conditional_losses_252077o#$>?;
4?1
'?$
hidden1_input?????????7
p

 
? "%?"
?
0?????????
? ?
F__inference_sequential_layer_call_and_return_conditional_losses_252157h#$7?4
-?*
 ?
inputs?????????7
p 

 
? "%?"
?
0?????????
? ?
F__inference_sequential_layer_call_and_return_conditional_losses_252180h#$7?4
-?*
 ?
inputs?????????7
p

 
? "%?"
?
0?????????
? ?
+__inference_sequential_layer_call_fn_251936b#$>?;
4?1
'?$
hidden1_input?????????7
p 

 
? "???????????
+__inference_sequential_layer_call_fn_252037b#$>?;
4?1
'?$
hidden1_input?????????7
p

 
? "???????????
+__inference_sequential_layer_call_fn_252117[#$7?4
-?*
 ?
inputs?????????7
p 

 
? "???????????
+__inference_sequential_layer_call_fn_252134[#$7?4
-?*
 ?
inputs?????????7
p

 
? "???????????
$__inference_signature_wrapper_252100?#$G?D
? 
=?:
8
hidden1_input'?$
hidden1_input?????????7"/?,
*
output ?
output?????????