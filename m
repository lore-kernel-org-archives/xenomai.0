From: "Niklaus Giger" <Niklaus.Giger@domain.hid>
Date: Fri, 15 Sep 2006 21:44:48 +0200
Message-ID: <eeevrh$rns$1@domain.hid>
Sender: news <news@domain.hid>
Subject: [Xenomai-core] Odd behaviour of vxworks
Reply-To: Niklaus.Giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: 0@domain.hid

Hi

First I was surprised that a lot of vxworks return -1 unless
running inside a thread created by taskSpawn, e.g. taskIdSelf
or taskMCreate return -1.

Then I did added a very simple sequence of
semMCreate
semTake
semGive
and now semGive returned me -1 (ERROR). This puzzled me even more, as
this is the same sequence where the simulator has no problem
and where semGive returns 0 (OK).

I modified satch.c (see patch below) to get a simple test case (in UVM).
Native and UVM are built-in.
Output is:

_user_init: semMCreate 4 taskId -1
__xeno_user_init: semTake 4 status -1 -1 taskId -1
__xeno_user_init: semGive 4 status -1 -1 taskId -1
consumer_task: task 6 ConsumerTask
producer_task: task SEM_DELETE_SAFE 7 ProducerTask

producer_task: semMCreate 8 taskId 7
producer_task: semTake 8 status 0 0 taskId 7
producer_task: semGive 8 status -1 1441896 taskId 7
producer_task: semDelete 8 status 0 1441896 taskId 7
producer_task: task 7 ProducerTask

producer_task: semMCreate 9 taskId 7
producer_task: semTake 9 status 0 1441896 taskId 7
producer_task: semGive 9 status -1 1441896 taskId 7
Now playing Surfing With The Alien...
Now playing Lords of Karma...
Now playing Banana Mango...

I am reproduced these results with Xenomai trunk revision 1618.

Using a simulator (built with an earlier version) outputs like this:
Xenomai/sim: real-time nucleus v2.2-rc1 (Engines Of Creation) loaded.
starting VxWorks services.

__xeno_user_init: semMCreate 269073416 taskId 268720448
__xeno_user_init: semTake 269073416 status 0 0 taskId 268720448
__xeno_user_init: semGive 269073416 status 0 0 taskId 268720448
consumer_task: task 269074952 ConsumerTask
producer_task: task SEM_DELETE_SAFE 269075976 ProducerTask

producer_task: semMCreate 269073544 taskId 269075976
producer_task: semTake 269073544 status 0 0 taskId 269075976
producer_task: semGive 269073544 status 0 0 taskId 269075976
producer_task: semDelete 269073544 status 0 0 taskId 269075976
producer_task: task 269075976 ProducerTask

producer_task: semMCreate 269073544 taskId 269075976
producer_task: semTake 269073544 status 0 0 taskId 269075976
producer_task: semGive 269073544 status 0 0 taskId 269075976

Any hint would be appreciated.

Best regards

Niklaus Giger

begin 666 satch.patch
M26YD97@domain.hid=&-H+F,*/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/0HM+2T@<V%T
M8V@N8PDH4F5V:7-I;VX@,34V,BD**RLK('-A=&-H+F,)*$%R8F5I='-K;W!I
M92D*0$`@+30R+#8@domain.hid+#<@0$`*("-D969I;F4@domain.hid
M>"D*(`H@(V1E9FEN92!X;G!R:6YT9B!P<FEN=&8**R-D969I;F4@domain.hid
M;6%?=&5S=`H@"B!I;G0@domain.hid(&%R9V,L(&-H87(@*F%R9W9;72D*
M('L*0$`@+3DQ+#8@domain.hid+#<@0$`*("`@("!C:&%R("IM<V<["B`@("`@:6YT
M('-Z.PH@"BL@("`@<')I;G1F*"(E<SH@=&%S:R`E9"`E<UQN(BP@7U]&54Y#
M5$E/3E]?+"!T87-K261396QF*"DL('1A<VM.86UE*'1A<VM)9%-E;&8H*2DI
M.PH@("`@(&9O<B`H.SLI"B`)>PH@"71A<VM$96QA>2A#3TY354U%4E]704E4
M*3L*0$`@+3$P-2PW("LQ,#<L,C8@domain.hid<V<@
M/2`P.PH@("`@(&-O;G-T(&-H87(@*G,["BLC:69D968@domain.hid%?=&5S
M=`HK("`@(&EN="!S96UA7S$L('-E;6%?,BP@<W1A='5S.PHK("`@('!R:6YT
M9B@B)7,Z('1A<VL@4T5-7T1%3$5415]3049%("5D("5S7&XB+"!?7T953D-4
M24].7U\L('1A<VM)9%-E;&8H*2P@=&%S:TYA;64H=&%S:TED4V5L9B@I*2D[
M"BL@("`@<V5M85\Q(#T@<V5M34-R96%T92A314U?45]04DE/4DE467Q314U?
M1$5,151%7U-!1D5\4T5-7TE.5D524TE/3E]3049%("D["BL@("`@<')I;G1F
M*")<;B5S.B!S96U-0W)E871E("5D('1A<VM)9"`E9%QN(BP@7U]&54Y#5$E/
M3E]?+"!S96UA7S$L('1A<VM)9%-E;&8H*2D["BL@("`@<W1A='5S(#T@<V5M
M5&%K92AS96UA7S$L(%=!251?1D]2159%4BD["BL@("`@<')I;G1F*"(E<SH@
M<V5M5&%K92`E9"!S=&%T=7,@)60@domain.hid@=&%S:TED("5D7&XB+"!?7T953D-4
M24].7U\L('-E;6%?,2P@<W1A='5S+"!E<G)N;T=E="@I+"!T87-K261396QF
M*"DI.PHK("`@('-T871U<R`]('-E;4=I=F4H<V5M85\Q*3L**R`@("!P<FEN
M=&8H(B5S.B!S96U':79E("5D('-T871U<R`E9"`E9"!T87-K260@domain.hid<;B(L
M(%]?1E5.0U1)3TY?7RP@<V5M85\Q+"!S=&%T=7,L(&5R<FYO1V5T*"DL('1A
M<VM)9%-E;&8H*2D["BL@("`@<W1A='5S(#T@<V5M1&5L971E*'-E;6%?,2D[
M"BL@("`@<')I;G1F*"(E<SH@<V5M1&5L971E("5D('-T871U<R`E9"`E9"!T
M87-K260@domain.hid<;B(L(%]?1E5.0U1)3TY?7RP@<V5M85\Q+"!S=&%T=7,L(&5R
M<FYO1V5T*"DL('1A<VM)9%-E;&8H*2D["B`**R`@("!P<FEN=&8H(B5S.B!T
M87-K("5D("5S7&XB+"!?7T953D-424].7U\L('1A<VM)9%-E;&8H*2P@=&%S
M:TYA;64H=&%S:TED4V5L9B@I*2D["BL@("`@<V5M85\R(#T@<V5M34-R96%T
M92A314U?45]04DE/4DE462!\(%-%35])3E9%4E-)3TY?4T%&12`I.PHK("`@
M('!R:6YT9B@B7&XE<SH@<V5M34-R96%T92`E9"!T87-K260@domain.hid<;B(L(%]?
M1E5.0U1)3TY?7RP@<V5M85\R+"!T87-K261396QF*"DI.PHK("`@('-T871U
M<R`]('-E;51A:V4H<V5M85\R+"!704E47T9/4D5615(I.PHK("`@('!R:6YT
M9B@B)7,Z('-E;51A:V4@domain.hid@<W1A='5S("5D("5D('1A<VM)9"`E9%QN(BP@
M7U]&54Y#5$E/3E]?+"!S96UA7S(L('-T871U<RP@97)R;F]'970H*2P@=&%S
M:TED4V5L9B@I*3L**R`@("!S=&%T=7,@/2!S96U':79E*'-E;6%?,BD["BL@
M("`@<')I;G1F*"(E<SH@<V5M1VEV92`E9"!S=&%T=7,@)60@domain.hid@=&%S:TED
M("5D7&XB+"!?7T953D-424].7U\L('-E;6%?,BP@<W1A='5S+"!E<G)N;T=E
M="@I+"!T87-K261396QF*"DI.PHK(V5N9&EF"B`@("`@9F]R("@[.RD*(`E[
M"B`)=&%S:T1E;&%Y*%!23T150T527U1224<I.PI`0"`M,3(P+#@@*S$T,2PQ
M."!`0`H@:6YT(')O;W1?=&AR96%D7VEN:70@domain.hid
M97-S86=E7W%I9"`](&US9U%#<F5A=&4H,38L<VEZ96]F*&-H87(@*BDL35-'
M7U%?1DE&3RD["BLC:69D968@domain.hid%?=&5S=`HK("`@:6YT('-E;6%?
M,2P@<W1A='5S.PHK("`@<V5M85\Q(#T@<V5M34-R96%T92A314U?45]04DE/
M4DE462!\(%-%35])3E9%4E-)3TY?4T%&12`I.PHK("`@<')I;G1F*")<;B5S
M.B!S96U-0W)E871E("5D('1A<VM)9"`E9%QN(BP@7U]&54Y#5$E/3E]?+"!S
M96UA7S$L('1A<VM)9%-E;&8H*2D["BL@("!S=&%T=7,@/2!S96U486ME*'-E
M;6%?,2P@5T%)5%]&3U)%5D52*3L**R`@('!R:6YT9B@B)7,Z('-E;51A:V4@
M)60@<W1A='5S("5D("5D('1A<VM)9"`E9%QN(BP@7U]&54Y#5$E/3E]?+"!S
M96UA7S$L('-T871U<RP@97)R;F]'970H*2P@=&%S:TED4V5L9B@I*3L**R`@
M('-T871U<R`]('-E;4=I=F4H<V5M85\Q*3L**R`@('!R:6YT9B@B)7,Z('-E
M;4=I=F4@domain.hid@<W1A='5S("5D("5D('1A<VM)9"`E9%QN(BP@7U]&54Y#5$E/
M3E]?+"!S96UA7S$L('-T871U<RP@97)R;F]'970H*2P@=&%S:TED4V5L9B@I
M*3L**R-E;F1I9@domain.hid"`](&US9U%#<F5A=&4H,38L
M<VEZ96]F*&-H87(@*BDL35-'7U%?1DE&3RD["BL*("`@("!C;VYS=6UE<E]T
M:60@domain.hid&%S:R(L"B`)"0D@("`@($-/3E-5
:34527U1!4TM?4%))+`H@"0D)("`@("`P+`H`
`
end


