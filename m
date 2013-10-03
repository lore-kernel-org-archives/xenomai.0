Message-ID: <524D764F.80301@axelsw.it>
Date: Thu, 03 Oct 2013 15:51:11 +0200
From: Roberto Bielli <roberto.bielli@axelsw.it>
MIME-Version: 1.0
References: <524ABEED.4090609@axelsw.it>	<114ba7d302c4a7b01d85caf23c52fa10.squirrel@127.0.0.1>	<524AC518.2040901@axelsw.it>	<524B1E12.2010909@xenomai.org>	<524D2C77.6050706@axelsw.it>	<524D70A4.6020007@xenomai.org>
	<CAEk6gTB+KRO_3_x+i8hOiGXeRxSXP9WMk42CJCnz87SWSdKQjQ@mail.gmail.com>
In-Reply-To: <CAEk6gTB+KRO_3_x+i8hOiGXeRxSXP9WMk42CJCnz87SWSdKQjQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] high latency with imx6q without smp
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drasko DRASKOVIC <drasko.draskovic@gmail.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

the results of xeno-test are these.
When i execute the xeno-test i run simultaneously a telnet with an 'ls 
-lr /' for increase etherne interrupts.





  /usr/xenomai/bin/xeno-test
Started child 3089: /bin/sh /usr/xenomai/bin/xeno-test-run-wrapper 
/usr/xenomai/                        bin/xeno-test
[[43]+echo 0
[[45]+/usr/xenomai/bin/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 350.233 ns, rejected 1/10000
inlined llimd: 0x79364d9364d9362f: 1443.833 ns, rejected 5/10000
inlined llmulshft: 0x79364d92ffffffe1: 25.233 ns, rejected 2/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 46.333 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 359.866 ns, rejected 2/10000
out of line llimd: 0x79364d9364d9362f: 1445.400 ns, rejected 7/10000
out of line llmulshft: 0x79364d92ffffffe1: 21.133 ns, rejected 0/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 35.666 ns, rejected 1/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 348.999 ns, rejected 4/10000
inlined llimd: 0x86c9b26c9b26c9d1: 1456.033 ns, rejected 2/10000
inlined llmulshft: 0x86c9b26d0000001e: 30.433 ns, rejected 1/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 46.266 ns, rejected 1/10000
out of line calibration: 0x0000000000000000: 360.933 ns, rejected 0/10000
out of line llimd: 0x86c9b26c9b26c9d1: 1444.900 ns, rejected 7/10000
out of line llmulshft: 0x86c9b26d0000001e: 18.733 ns, rejected 1/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 34.733 ns, rejected 0/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 350.833 ns, rejected 2/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 44.333 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 359.466 ns, rejected 1/10000
out of line nodiv_ullimd: 0x79364d9364d9362f: 36.366 ns, rejected 0/10000
[[46]+/usr/xenomai/bin/clocktest -C 42 -T 30
== Tested clock: 42 (CLOCK_HOST_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
   0                  1.5            0.011          0 0.0
[[47]+/usr/xenomai/bin/switchtest -T 30
== Testing FPU check routines...
d0: 1 != 2
d1: 1 != 2
d2: 1 != 2
d3: 1 != 2
d4: 1 != 2
d5: 1 != 2
d6: 1 != 2
d7: 1 != 2
d8: 1 != 2
d9: 1 != 2
d10: 1 != 2
d11: 1 != 2
d12: 1 != 2
d13: 1 != 2
d14: 1 != 2
d15: 1 != 2
== FPU check routines: OK.
== Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4 
rtk_fp_ufpp0-5 rtk                        _fp_ufpp0-6 rtup0-7 rtup0-8 
rtup_ufpp0-9 rtup_ufpp0-10 rtus0-11 rtus0-12 
rtus_uf                        ps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16 
rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19                         
rtuo_ufps0-20 rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22
RTT|  00:00:01
RTH|---------cpu|ctx switches|-------total
RTD|           0|       16629|       16629
RTD|           0|       16698|       33327
RTD|           0|       16765|       50092
RTD|           0|       16976|       67068
RTD|           0|       16903|       83971
RTD|           0|       16767|      100738
RTD|           0|       16838|      117576
RTD|           0|       16700|      134276
RTD|           0|       16765|      151041
RTD|           0|       16698|      167739
RTD|           0|       16696|      184435
RTD|           0|       16840|      201275
RTD|           0|       17039|      218314
RTD|           0|       16840|      235154
RTD|           0|       16901|      252055
RTD|           0|       16769|      268824
RTD|           0|       16696|      285520
RTD|           0|       16767|      302287
RTD|           0|       16698|      318985
RTD|           0|       16702|      335687
RTD|           0|       16974|      352661
RTT|  00:00:22
RTH|---------cpu|ctx switches|-------total
RTD|           0|       16901|      369562
RTD|           0|       16840|      386402
RTD|           0|       16903|      403305
RTD|           0|       16700|      420005
RTD|           0|       16763|      436768
RTD|           0|       16767|      453535
RTD|           0|       16700|      470235
RTD|           0|       16767|      487002
RTD|           0|       14143|      501145
[[48]+/usr/xenomai/bin/cond-torture-native
simple_condwait
relative_condwait
absolute_condwait
sig_norestart_condwait
sig_restart_condwait
sig_norestart_condwait_mutex
sig_restart_condwait_mutex
sig_norestart_double
sig_restart_double
cond_destroy_whilewait
Test OK
[[49]+/usr/xenomai/bin/cond-torture-posix
simple_condwait
relative_condwait
absolute_condwait
sig_norestart_condwait
sig_restart_condwait
sig_norestart_condwait_mutex
sig_restart_condwait_mutex
sig_norestart_double
sig_restart_double
cond_destroy_whilewait
Test OK
[[50]+/usr/xenomai/bin/mutex-torture-native
simple_wait
recursive_wait
timed_mutex
mode_switch
pi_wait
lock_stealing
NOTE: lock_stealing mutex_trylock: not supported
deny_stealing
simple_condwait
recursive_condwait
auto_switchback
Test OK
[[51]+/usr/xenomai/bin/mutex-torture-posix
simple_wait
recursive_wait
errorcheck_wait
timed_mutex
mode_switch
pi_wait
lock_stealing
NOTE: lock_stealing mutex_trylock: not supported
deny_stealing
simple_condwait
recursive_condwait
auto_switchback
Test OK
[[53]+start_load
[[13]+echo start_load
[[55]+check_alive /usr/xenomai/bin/latency
[[8]+echo check_alive /usr/xenomai/bin/latency
[[57]+wait_load
[[18]+read rc
Started child 3171: dohell 900
Started child 3172: /usr/xenomai/bin/latency
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|      9.333|     15.999|     20.333|       0|     0| 9.333|     20.333
RTD|      9.333|     15.999|     20.999|       0|     0| 9.333|     20.999
RTD|      9.333|     16.333|     20.666|       0|     0| 9.333|     20.999
RTD|      8.999|     15.666|     21.333|       0|     0| 8.999|     21.333
RTD|      9.333|     15.999|     21.333|       0|     0| 8.999|     21.333
RTD|      9.333|     15.999|     21.333|       0|     0| 8.999|     21.333
RTD|      9.333|     15.999|     20.999|       0|     0| 8.999|     21.333
RTD|      9.333|     15.999|     20.999|       0|     0| 8.999|     21.333
RTD|      8.999|     16.333|     21.333|       0|     0| 8.999|     21.333
RTD|      8.999|     15.666|     20.999|       0|     0| 8.999|     21.333
RTD|      9.333|     15.999|     21.999|       0|     0| 8.999|     21.999
RTD|      8.999|     16.333|     20.999|       0|     0| 8.999|     21.999
RTD|      9.333|     16.333|     21.333|       0|     0| 8.999|     21.999
RTD|      9.666|     15.999|     20.999|       0|     0| 8.999|     21.999
RTD|      8.999|     15.666|     21.333|       0|     0| 8.999|     21.999
RTD|      9.333|     15.999|     20.666|       0|     0| 8.999|     21.999
RTD|      9.333|     15.999|     20.999|       0|     0| 8.999|     21.999
RTD|      9.333|     15.999|     21.333|       0|     0| 8.999|     21.999
RTD|      9.666|     15.999|     20.999|       0|     0| 8.999|     21.999
RTD|      9.666|     16.333|     20.999|       0|     0| 8.999|     21.999
RTD|      8.999|     15.666|     21.333|       0|     0| 8.999|     21.999
RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|      9.333|     15.999|     20.999|       0|     0| 8.999|     21.999
RTD|      9.333|     16.333|     20.666|       0|     0| 8.999|     21.999
RTD|      9.333|     15.999|     21.333|       0|     0| 8.999|     21.999
RTD|      9.333|     15.999|     20.666|       0|     0| 8.999|     21.999
RTD|      8.999|     15.666|     21.333|       0|     0| 8.999|     21.999
RTD|      8.999|     15.999|     20.666|       0|     0| 8.999|     21.999
RTD|      9.333|     15.999|     20.666|       0|     0| 8.999|     21.999
RTD|      9.666|     15.999|     20.999|       0|     0| 8.999|     21.999
RTD|      9.666|     16.333|     21.333|       0|     0| 8.999|     21.999
RTD|      9.333|     15.999|     20.999|       0|     0| 8.999|     21.999
RTD|      8.999|     15.666|     20.999|       0|     0| 8.999|     21.999
RTD|      9.333|     16.333|     21.333|       0|     0| 8.999|     21.999
RTD|      9.333|     15.999|     21.333|       0|     0| 8.999|     21.999
RTD|      9.333|     16.333|     20.999|       0|     0| 8.999|     21.999
RTD|      9.333|     16.333|     21.666|       0|     0| 8.999|     21.999
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|      8.999|     15.999|     21.999|       0|     0| 00:00:37/00:00:37

Il 03/10/2013 15:33, Drasko DRASKOVIC ha scritto:
> On Thu, Oct 3, 2013 at 3:27 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 10/03/2013 10:36 AM, Roberto Bielli wrote:
>>> Hi,
>>>
>>> i reduced drastically the latency disabling the cpu frequency scaling ->
>>> CONFIG_CPU_FREQ ( max 25us ).
>> This seems a bit too good to be true. Chances are higher to approach the
>> real worst case latency on a system under load.
> Can xeno-test give good and reliable figures for this case?
>
> BR,
> Drasko


-- 
+------------------------------------------------------------------------------------------------+
							
Roberto Bielli
Sviluppo Software					
Axel S.r.l.					
							
Via Del Cannino, 3 				
21020 Crosio Della Valle			
Varese - Italy					
							
Telefono: +39 0332 949600			
Fax:      +39 0332 969315			
							
E-mail:   roberto.bielli@axelsw.it	
Web Site: www.axelsw.it

+------------------------------------------------------------------------------------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate e ad uso esclusivo del destinatario.
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
I dati utilizzati per la spedizione del presente messaggio sono utilizzati da Axel S.r.l., titolare del trattamento,
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo autorizzata la divulgazione a terzi.
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o cancellazione dei Vostri dati: info@axelsw.it

This e-mail and any attachments is confidential and may contain privileged information
intended for the addressee(s) only. Dissemination, copying, printing or use by anybody
else is unauthorised. If you are not the intended recipient,
please delete this message and any attachments and advise the sender
by return e-mail.Thank you.  			
							
+------------------------------------------------------------------------------------------------+


