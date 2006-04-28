From: "Niklaus Giger" <Niklaus.Giger@domain.hid>
Date: Fri, 28 Apr 2006 09:01:11 +0200
Message-ID: <e2sejo$4k2$1@domain.hid>
Sender: news <news@domain.hid>
Subject: [Xenomai-core] Running vxworks testsuite under vxWorks
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

Hi

I am trying to run the vxworks testsuite on my PPC405 vxworks target.

Using the attached patched I manage to run a few of them. I have the
following questions:

Could a patch along these proposed changes be accepted? Where does it
need improvements/changes?

Some remarks about the patch:
- include/nucleus/queue.h needed for xntest. is #ifdef __XENO__ correct?
- made tests less verbose by removing xnarch_printf in xntest_assert.
  I would prefer a silent method where each test only emits a summary
 and a option to run generate verbose output in case of problems.
- static inline caused problem with Tornado 2.2.1 (gcc 2.96)

Some questions:
The tests do not clean up. Should I add a call to __xeno_user_exit in
xntest_finish and add cleanup code into each  __xeno_user_exit?

Best regards

Niklaus Giger

begin 666 vx_test.patch
M26YD97@domain.hid(&EN8VQU9&4O;G5C;&5U<R]Q=65U92YH#0H]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]#0HM+2T@:6YC;'5D92]N=6-L975S+W%U975E+F@)*%)E=FES
M:6]N(#$P,#4I#0HK*RL@:6YC;'5D92]N=6-L975S+W%U975E+F@)*$%R8F5I
M='-K;W!I92D-"D!`("TR,2PW("LR,2PQ,"!`0`T*("-I9FYD968@domain.hid]?
M3E5#3$554U]1545515]("B`C9&5F:6YE(%]814Y/7TY50TQ%55-?455%545?
M2`H@"BLC:69D968@domain.hid<&5S
M+F@^"BLC96YD:68**PH@(VEN8VQU9&4@/&YU8VQE=7,O8V]R92YH/@H@"B`O
M*B!"87-I8R!E;&5M96YT(&AO;&1E<B`J+PI);F1E>#H@<VEM+W-K:6YS+W9X
M=V]R:W,O=&5S='-U:71E+WAN=&5S="YC#0H]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]#0HM+2T@<VEM+W-K:6YS+W9X=V]R:W,O=&5S='-U:71E+WAN=&5S="YC
M"2A2979I<VEO;B`Q,#`U*0T**RLK('-I;2]S:VEN<R]V>'=O<FMS+W1E<W1S
M=6ET92]X;G1E<W0N8PDH07)B96ET<VMO<&EE*0T*0$`@+3$X+#<@*S$X+#(X
M($!`#0H@("H*("`J+PH@"BLC:69D968@domain.hid
M=6-L975S+WAE;F]M86DN:#X**R-E;'-E"BMT>7!E9&5F(&EN="!A=&]M:6-?
M9FQA9W-?=#L**W1Y<&5D968@domain.hid=&EM97)?=#L**W1Y<&5D968@domain.hid
M('AN;&]C:U]T.PHK='EP961E9B!I;G0@<W!L7W0["BLC9&5F:6YE(%A.05)#
M2%],3T-+7U5.3$]#2T5$(#`**R-I;F-L=61E(#QS=')I;F<N:#X**R-I;F-L
M=61E(#QL;V=,:6(N:#X**PHK(V1E9FEN92!I;FQI;F4@domain.hid`\
M;G5C;&5U<R]Q=65U92YH/@HK(W5N9&5F(&EN;&EN90HK"BLC9&5F:6YE('AN
M<&]D7V9A=&%L*&%R9RD@;&]G37-G*&%R9RP@(#$L(#(L(#,L(#0L(#4L(#8I
M(`HK(V1E9FEN92!X;FUA;&QO8R!M86QL;V,**R-D969I;F4@>&YF<F5E(&9R
M964**R-D969I;F4@>&YL;V-K7V=E=%]I<G%S879E*&%R9S$L(&%R9S(I"BLC
M9&5F:6YE('AN;&]C:U]P=71?:7)Q<F5S=&]R92AA<F<Q+"!A<F<R*0HK(V1E
M9FEN92!X;G1H<F5A9%]N86UE('1A<VM.86UE"BLC96YD:68*("-I;F-L=61E
M(")X;G1E<W0N:"(*("-I;F-L=61E(#QS=&1A<F<N:#X*(`I`0"`M-#4L-B`K
M-C8L.2!`0`T*('-T871I8R!I;G0@=&5S=',["B`*(`HK(VEF;F1E9B!?7UA%
M3D]?7PHK(V1E9FEN92!I;FQI;F4**R-E;F1I9@domain.hid=&%T:6,@:6YL:6YE
M('AN:&]L9&5R7W0@domain.hid;&]T*2!["B`@
M("`@>&YH;VQD97)?="`J:&]L9&5R(#T@<7-L;W0M/FAE860N;&%S=#L*0$`@
M+38P+#<@*S@T+#<@0$`-"B`@("`@<F5T=7)N("@H(7-T<C$@?'P@(7-T<C(I
M(#\@<W1R,2$]<W1R,B`Z('-T<F-M<"AS='(Q+"!S='(R*2D["B!]"B`*+7-T
M871I8R!V;VED(&EN=&5R<G5P=%]T97-T("AV;VED("ID=6UM>2D**W-T871I
M8R!I;FQI;F4@domain.hid<G)U<'1?=&5S="`H=F]I9"`J9'5M;7DI"B![
M"B`@("!X;G!O9%]F871A;"@B=&5S="!I;G1E<G)U<'1E9"!B>2!W871C:&1O
M9RY<;B(I.PH@?0I`0"`M-S(L."`K.38L,3`@0$`-"B`@("`@<W!L7W0@<SL*
M(`H@("`@('AN;&]C:U]G971?:7)Q<V%V92@domain.hid=&5S=%]L;V-K+"!S*3L**R-I
M9F1E9B!?7UA%3D]?7PH@("`@('AN=&EM97)?:6YI="@F=V%T8VAD;V<L(&EN
M=&5R<G5P=%]T97-T+"`P*3L*("`@("!X;G1I;65R7W-T87)T*"9W871C:&1O
M9RP@>&YP;V1?;G,R=&EC:W,H=&5S=%]T:6UE;W5T("H@,3`P,#`P,%5,3"DL
M(%A.7TE.1DE.251%*3L**R-E;F1I9@domain.hid<FMS7W$I
M.PH@("`@('1E<W1S/3`["D!`("TQ.3`L-2`K,C$V+#4@domain.hid
M;F%R8VA?<')I;G1F*"(E<SHE9"P@=&5S="!F:6YI<VAE9#H@)60@domain.hid
M97,O("5D('1E<W1S7&XB+`H@("`@("`@("`@("`@("`@("`@9FEL92P@;&EN
M92P@=&5S=%]F86EL=7)E<RP@=&5S=',I.PHM("`@('AN<&]D7V9A=&%L*").
M;W)M86P@97AI="Y<;B(I.PHK("`@('AN87)C:%]P<FEN=&8H(DYO<FUA;"!E
M>&ET+EQN(BD["B!]"DEN9&5X.B!S:6TO<VMI;G,O=GAW;W)K<R]T97-T<W5I
M=&4O=GAW;W)K<U]T97-T+F@-"CT]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T-"BTM
M+2!S:6TO<VMI;G,O=GAW;W)K<R]T97-T<W5I=&4O=GAW;W)K<U]T97-T+F@)
M*%)E=FES:6]N(#$P,#4I#0HK*RL@<VEM+W-K:6YS+W9X=V]R:W,O=&5S='-U
M:71E+W9X=V]R:W-?=&5S="YH"2A!<F)E:71S:V]P:64I#0I`0"`M,C$L-R`K
M,C$L,3$@0$`-"B`C:69N9&5F('=X=V]R:W-?=&5S=%]H"B`C9&5F:6YE('=X
M=V]R:W-?=&5S=%]H"B`**R-I9F1E9B!?7UA%3D]?7PH@(VEN8VQU9&4@domain.hid
M=V]R:W,O=GAW;W)K<RYH/@HK(V5L<V4**R-I;F-L=61E(#QV>'=O<FMS+F@^
M"BLC96YD:68*("-I;F-L=61E(#QX;G1E<W0N:#X*(`H@(V1E9FEN92!415-4
M7T%34T525%]/2RAE>'!R*2`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@(%P*26YD97@domain.hid<R]V>'=O<FMS+W1E<W1S=6ET92]-
M86ME9FEL92YW:6X-"CT]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T-"BTM+2!S:6TO
M<VMI;G,O=GAW;W)K<R]T97-T<W5I=&4O36%K969I;&4N=VEN"2A2979I<VEO
M;B`P*0T**RLK('-I;2]S:VEN<R]V>'=O<FMS+W1E<W1S=6ET92]-86ME9FEL
M92YW:6X)*%)E=FES:6]N(#`I#0I`0"`M,"PP("LQ+#,Q($!`#0HK(R!.:6ML
M875S($=I9V5R+"`R."XP-"XP-@domain.hid;&4N=VEN('1O(&=E;F5R
M871E('1H92!V>'=O<FMS('1E<W0@domain.hid&]W<R!A(&=I
M=F5N('1A<F=E=`T**R,-"BLC(%EO=2!M=7-T(&%D87!T(&ET('1O('EO=7(@
M=&%R9V5T(&%N9"!C86QL(&9I<G-T('-O;65T:&EN9R!Y;W5R('1O<E9A<G,N
M8F%T(&QI:V4-"BLC($,Z7%!R;V=R86UM95QT;W)N861O7'0R,C%<:&]S=%QX
M.#8M=VEN,S)<8FEN7'1O<E9A<G,N8F%T+@T**R,@0V%L;"`B;6%K92YE>&4@
M+68@domain.hid;&4N=VEN('9X(B!T;R!C<F5A=&4@<V5V97)A;"`J+F\@9FEL
M97,@=&\@8F4@;&]A9&5D#0HK(R!M86YU86QL>2!O;B!Y;W5R('1A<F=E="X@
M5&AE;B!O;B!Y;W5R('1A<F=E="!R=6X@=&AE('1E<W1S(&)Y(&-A;&QI;F<@
M=GA?=7-E<E]I;FET+@T**PT**T-052`@("`@("`@("`@("`@/2!04$,T,#4-
M"BM43T],("`@("`@("`@("`@(#T@9VYU#0HK5$=47T1)4CTD*%=)3D1?0D%3
M12DO=&%R9V5T#0HK:6YC;'5D92`D*%1'5%]$25(I+V@O;6%K92]D969S+F)S
M<`T**VEN8VQU9&4@domain.hid/
M3TPI#0HK:6YC;'5D92`D*%1'5%]$25(I+V@O;6%K92]D969S+B0H5TE.1%](
M3U-47U194$4I#0HK#0HK0T9,04=3("L]("U/,B`M1$))5%-?4$527TQ/3D<]
M,S(@(`T**PT**W9P871H("4N8R`N+B\N+B\N+B\N+B]K<W)C+W-K:6YS+W9X
M=V]R:W,-"BL-"BM#0U])3D-,541%(#T@("`M22XN+RXN+RXN+RXN+VEN8VQU
M9&4@domain.hid;&1C87)D("4N:"D-"BL))"A#
M0RD@)"A#1DQ!1U,I("UC("0\(`T**PT**V]B:F5C=',@/2`D*'!A='-U8G-T
M("4N8RPE+F\L)"AW:6QD8V%R9"!T*BYC*2D-"BL-"BMV>#H@)"AO8FIE8W1S
M*2`@(`T**PT**V-L96%N.B`@("0H;V)J96-T<RD-"BL)<FT@)%X-"BL@("`@
M("`@#0I);F1E>#H@<VEM+W-K:6YS+W9X=V]R:W,O=&5S='-U:71E+WAN=&5S
M="YH#0H]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]#0HM+2T@<VEM+W-K:6YS+W9X
M=V]R:W,O=&5S='-U:71E+WAN=&5S="YH"2A2979I<VEO;B`Q,#`U*0T**RLK
M('-I;2]S:VEN<R]V>'=O<FMS+W1E<W1S=6ET92]X;G1E<W0N:`DH07)B96ET
M<VMO<&EE*0T*0$`@+3(Q+#$S("LR,2PR."!`0`T*("-I9FYD968@>&YT97-T
M7V@*("-D969I;F4@>&YT97-T7V@*(`HK(VEF9&5F(%]?6$5.3U]?"B`C:6YC
M;'5D92`\;G5C;&5U<R]P;V0N:#X**R-E;'-E"BMT>7!E9&5F(&EN="!X;G1H
M<F5A9%]T.PHK='EP961E9B!I;G0@domain.hid=&1I
M;RYH/@HK(VEN8VQU9&4@/&EN=$QI8BYH/@HK(VEN8VQU9&4@domain.hid<VM,:6(N
M:#X**R-I;F-L=61E(#QM<V=13&EB+F@^"BLC:6YC;'5D92`\97)R;F],:6(N
M:#X**R-I;F-L=61E(#QW9$QI8BYH/@HK(V1E9FEN92!X;F%R8VA?<')I;G1F
M('!R:6YT9@domain.hid<F5A9"!T87-K2613
M96QF"BLC9&5F:6YE(%]?>&5N;U]U<V5R7VEN:70@domain.hid<E]I;FET"BLC
M96YD:68*(`H@(V1E9FEN92!415-47U-405)4*&YU;2D@*'AN=&5S=%]S=&%R
M="@I*0H@"BMI;G0@>&YT97-T7V%S<V5R="AI;G0@<W1A='5S+"!C:&%R("IA
M<W-E<G1I;VXL(&-H87(@*F9I;&4L(&EN="!L:6YE*3L**PH@(V1E9FEN92!4
M15-47T%34T525"AA<W-E<G1I;VXI("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@7`H@9&\@>R`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@7`HM("`@('AN87)C:%]P<FEN=&8H7U]&24Q%7U\@(CHE9"P@(B`C87-S
M97)T:6]N(")<;B(L(%]?3$E.15]?*3L@("`@("`@("`@7`H@("`@('AN=&5S
M=%]A<W-E<G0H*&%S<V5R=&EO;BDL("-A<W-E<G1I;VXL(%]?1DE,15]?+"!?
M7TQ)3D5?7R`I.R`@("`@("`@7`H@?2!W:&EL92`H,"D*(`I`0"`M-3DL-"`K
M-S0L."!`0`T*('T*("-E;F1I9@domain.hid&5F(%]?6$5.3U]?"BLC:6YC
M;'5D92`B>&YT97-T+F,B"BLC96YD:68**PH@(V5N9&EF("\J("%X;G1E<W1?
%:"`J+PH`
`
end


