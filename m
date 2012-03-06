Message-ID: <4F560A6C.2080306@domain.hid>
Date: Tue, 06 Mar 2012 14:00:28 +0100
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid> <4F55C306.8020307@domain.hid>
	<4F55D765.7040705@domain.hid> <4F55E390.8090706@domain.hid>
	<4F55FE81.6000904@domain.hid>
In-Reply-To: <4F55FE81.6000904@domain.hid>
Content-Type: multipart/mixed; boundary="------------020601060309010103080909"
Subject: Re: [Xenomai-core] preemptive doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020601060309010103080909
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gilles,

here is the new trace.

Il 06/03/2012 13:09, Gilles Chanteperdrix ha scritto:
> On 03/06/2012 11:14 AM, Roberto Bielli wrote:
>> Hi,
>>
>> here is the trace.
> Please try to capture the xntimer_next_local_shot which happens before
> the bug to see if the timer ticks when expected.
>
> Also note that if we are going through __ipipe_preempt_schedule_irq, it
> means that the task eating the cpu is running in secondary mode. So, you
> should use T_WARNSW to see.
>
> Please keep the discussion on the mailing list.	
>


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
							
E-mail:   roberto.bielli@domain.hid	
Web Site: www.axelsw.it

+------------------------------------------------------------------------------------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate e ad uso esclusivo del destinatario.
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
I dati utilizzati per la spedizione del presente messaggio sono utilizzati da Axel S.r.l., titolare del trattamento,
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo autorizzata la divulgazione a terzi.
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o cancellazione dei Vostri dati: info@domain.hid

This e-mail and any attachments is confidential and may contain privileged information
intended for the addressee(s) only. Dissemination, copying, printing or use by anybody
else is unauthorised. If you are not the intended recipient,
please delete this message and any attachments and advise the sender
by return e-mail.Thank you.  			
							
+------------------------------------------------------------------------------------------------+


--------------020601060309010103080909
Content-Type: text/plain;
 name="Ipipe.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Ipipe.txt"

SS1waXBlIHdvcnN0LWNhc2UgdHJhY2luZyBzZXJ2aWNlIG9uIDIuNi4zMS9pcGlwZS0xLjE2
LTAyCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQpDUFU6IDAsIEJlZ2luOiA0MTM1NTk4ODczNzQgY3ljbGVzLCBUcmFjZSBQ
b2ludHM6IDI3ICgtMTAvKzEpLCBMZW5ndGg6IDgxIHVzCkNhbGlicmF0ZWQgbWluaW11bSB0
cmFjZS1wb2ludCBvdmVyaGVhZDogMS4wMjkgdXMKCiArLS0tLS0gSGFyZCBJUlFzICgnfCc6
IGxvY2tlZCkKIHwrLS0tLSA8dW51c2VkPgogfHwrLS0tIDx1bnVzZWQ+CiB8fHwrLS0gWGVu
b21haQogfHx8fCstIExpbnV4ICgnKic6IGRvbWFpbiBzdGFsbGVkLCAnKyc6IGN1cnJlbnQs
ICcjJzogY3VycmVudCtzdGFsbGVkKQogfHx8fHwgICAgICAgICAgICAgICAgICAgICAgICAr
LS0tLS0tLS0tLSBEZWxheSBmbGFnICgnKyc6ID4gMSB1cywgJyEnOiA+IDEwIHVzKQogfHx8
fHwgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICArLSBOTUkgbm9pc2UgKCdOJykK
IHx8fHx8ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfAogICAgICBUeXBlICAg
IFVzZXIgVmFsLiAgIFRpbWUgICAgRGVsYXkgIEZ1bmN0aW9uIChQYXJlbnQpCiB8ICAgK2Jl
Z2luICAgMHg4MDAwMDAwMSAgLTEyNiAgICAyLjMxMyAgX191cF9yZWFkKzB4MzAgKHVwX3Jl
YWQrMHgxOCkKIHwgICAjZW5kICAgICAweDgwMDAwMDAxICAtMTI0ICAgIDEuODgwICBfX3Vw
X3JlYWQrMHg1MCAodXBfcmVhZCsweDE4KQogICAgICNmdW5jICAgICAgICAgICAgICAgIC0x
MjIgICAgMS44NTAgIGlwaXBlX2NoZWNrX2NvbnRleHQrMHgxMCAoX191cF9yZWFkKzB4NWMp
CiAgICAgI2Z1bmMgICAgICAgICAgICAgICAgLTEyMCAgICAxLjUyMiAgX19pcGlwZV9yZXN0
b3JlX3Jvb3QrMHgxMCAoX191cF9yZWFkKzB4MTMwKQogICAgICNmdW5jICAgICAgICAgICAg
ICAgIC0xMTkgICAgMS4xNDkgIF9faXBpcGVfdW5zdGFsbF9yb290KzB4MTAgKF9faXBpcGVf
cmVzdG9yZV9yb290KzB4OTQpCiB8ICAgI2JlZ2luICAgMHg4MDAwMDAwMCAgLTExOCAgICAx
LjU5NyAgX19pcGlwZV91bnN0YWxsX3Jvb3QrMHgzNCAoX19pcGlwZV9yZXN0b3JlX3Jvb3Qr
MHg5NCkKIHwgICArZW5kICAgICAweDgwMDAwMDAwICAtMTE2ICAgIDEuNDMyICBfX2lwaXBl
X3Vuc3RhbGxfcm9vdCsweDk4IChfX2lwaXBlX3Jlc3RvcmVfcm9vdCsweDk0KQogICAgICtm
dW5jICAgICAgICAgICAgICAgIC0xMTUgICAgMi45NzAgIGlwaXBlX2NoZWNrX2NvbnRleHQr
MHgxMCAoX191cF9yZWFkKzB4MTM4KQogICAgICtmdW5jICAgICAgICAgICAgICAgIC0xMTIg
IDEwNy41MDcgIF9faXBpcGVfY2hlY2tfcm9vdCsweDEwIChyZXRfZnJvbV9leGNlcHRpb24r
MHg0KQogfCAgICtmdW5jICAgICAgICAgICAgICAgICAgLTQgICAgNC42NTYgIF9faXBpcGVf
Z3JhYl9pcnErMHgxMCAoX19pcnFfdXNyKzB4NzApCj58ICAgK2JlZ2luICAgMHhmZmZmZmZm
ZiAgICAgMCsgICAyLjQ2MiAgX19pcGlwZV9ncmFiX2lycSsweDVjIChfX2lycV91c3IrMHg3
MCkKOnwgICArZnVuYyAgICAgICAgICAgICAgICAgICAyKyAgIDMuNjI2ICBfX2lwaXBlX2hh
bmRsZV9pcnErMHgxNCAoX19pcGlwZV9ncmFiX2lycSsweDY4KQo6fCAgICtmdW5jICAgICAg
ICAgICAgICAgICAgIDYrICAgMi4xMDQgIF9faXBpcGVfYWNrX3RpbWVyaXJxKzB4MTAgKF9f
aXBpcGVfaGFuZGxlX2lycSsweDljKQo6fCAgICtmdW5jICAgICAgICAgICAgICAgICAgIDgr
ICAgMi44MDUgIF9faXBpcGVfYWNrX2xldmVsX2lycSsweDEwIChfX2lwaXBlX2Fja190aW1l
cmlycSsweDI0KQo6fCAgICtmdW5jICAgICAgICAgICAgICAgICAgMTErICAgMS43NzYgIG14
Y19tYXNrX2lycSsweDEwIChfX2lwaXBlX2Fja19sZXZlbF9pcnErMHgzYykKOnwgICArZnVu
YyAgICAgICAgICAgICAgICAgIDEyKyAgIDEuNjg2ICBteGNfbWFza19pcnErMHgxMCAoX19p
cGlwZV9hY2tfbGV2ZWxfaXJxKzB4NTQpCjp8ICAgK2Z1bmMgICAgICAgICAgICAgICAgICAx
NCsgICAxLjUwNyAgX19pcGlwZV9tYWNoX2Fja3RpbWVyKzB4MTAgKF9faXBpcGVfYWNrX3Rp
bWVyaXJxKzB4MjgpCjp8ICAgK2Z1bmMgICAgICAgICAgICAgICAgICAxNSsgICAxLjYxMSAg
X19pcGlwZV9lbmRfbGV2ZWxfaXJxKzB4MTAgKF9faXBpcGVfYWNrX3RpbWVyaXJxKzB4Mzgp
Cjp8ICAgK2Z1bmMgICAgICAgICAgICAgICAgICAxNysgICAyLjI1MyAgbXhjX3VubWFza19p
cnErMHgxMCAoX19pcGlwZV9lbmRfbGV2ZWxfaXJxKzB4MjgpCjp8ICAgK2Z1bmMgICAgICAg
ICAgICAgICAgICAxOSsgICAyLjI4MyAgX19pcGlwZV9kaXNwYXRjaF93aXJlZCsweDEwIChf
X2lwaXBlX2hhbmRsZV9pcnErMHhhOCkKOnwgICArZnVuYyAgICAgICAgICAgICAgICAgIDIy
KyAgIDIuMTk0ICBfX2lwaXBlX2Rpc3BhdGNoX3dpcmVkX25vY2hlY2srMHgxMCAoX19pcGlw
ZV9kaXNwYXRjaF93aXJlZCsweDg0KQo6fCAgIyBmdW5jICAgICAgICAgICAgICAgICAgMjQr
ICAgMi43NzYgIHhuaW50cl9jbG9ja19oYW5kbGVyKzB4MTAgKF9faXBpcGVfZGlzcGF0Y2hf
d2lyZWRfbm9jaGVjaysweDY4KQo6fCAgIyBmdW5jICAgICAgICAgICAgICAgICAgMjcrICAg
NS4zODggIHhudGltZXJfdGlja19hcGVyaW9kaWMrMHgxNCAoeG5pbnRyX2Nsb2NrX2hhbmRs
ZXIrMHg0NCkKOnwgICMgZnVuYyAgICAgICAgICAgICAgICAgIDMyKyAgIDIuMzEzICB4bnRo
cmVhZF9wZXJpb2RpY19oYW5kbGVyKzB4MTAgKHhudGltZXJfdGlja19hcGVyaW9kaWMrMHhh
OCkKOnwgICMgZnVuYyAgICAgICAgICAgICAgICAgIDM0KyAgIDQuMDI5ICB4bnBvZF9yZXN1
bWVfdGhyZWFkKzB4MTAgKHhudGhyZWFkX3BlcmlvZGljX2hhbmRsZXIrMHgyYykKOnwgICMg
WyAxNDExXSB0YXNrMm1zIDk5ICAgIDM4KyAgIDguNjg2ICB4bnBvZF9yZXN1bWVfdGhyZWFk
KzB4NmMgKHhudGhyZWFkX3BlcmlvZGljX2hhbmRsZXIrMHgyYykKOnwgICMgZnVuYyAgICAg
ICAgICAgICAgICAgIDQ3KyAgIDEuNjU2ICB4bnRocmVhZF90aW1lb3V0X2hhbmRsZXIrMHgx
MCAoeG50aW1lcl90aWNrX2FwZXJpb2RpYysweGE4KQo6fCAgIyBmdW5jICAgICAgICAgICAg
ICAgICAgNDkrICAgMi4yMzggIHhucG9kX3Jlc3VtZV90aHJlYWQrMHgxMCAoeG50aHJlYWRf
dGltZW91dF9oYW5kbGVyKzB4MzQpCjp8ICAjIFsgMTQxMl0gdGFza1ByaW4gMSAgICA1MSsg
ICAyLjQ3NyAgeG5wb2RfcmVzdW1lX3RocmVhZCsweDZjICh4bnRocmVhZF90aW1lb3V0X2hh
bmRsZXIrMHgzNCkKOnwgICMgZnVuYyAgICAgICAgICAgICAgICAgIDUzKyAgIDMuODgwICB4
bnRpbWVyX25leHRfbG9jYWxfc2hvdCsweDEwICh4bnRpbWVyX3RpY2tfYXBlcmlvZGljKzB4
MjU4KQo6fCAgIyBldmVudCAgIHRpY2tAMTk2OSAgICAgNTcrICAgMi4yMzggIHhudGltZXJf
bmV4dF9sb2NhbF9zaG90KzB4Y2MgKHhudGltZXJfdGlja19hcGVyaW9kaWMrMHgyNTgpCjp8
ICAjIGZ1bmMgICAgICAgICAgICAgICAgICA2MCsgICA0LjA4OSAgX19pcGlwZV9tYWNoX3Nl
dF9kZWMrMHgxMCAoeG50aW1lcl9uZXh0X2xvY2FsX3Nob3QrMHgxMTApCjp8ICAjIGZ1bmMg
ICAgICAgICAgICAgICAgICA2NCsgICAzLjEzNCAgX194bnBvZF9zY2hlZHVsZSsweDE0ICh4
bmludHJfY2xvY2tfaGFuZGxlcisweGNjKQo6fCAgIyBbIDE0MTNdIGNhdCAgICAgLTEgICAg
NjcrICAgMi40MzIgIF9feG5wb2Rfc2NoZWR1bGUrMHg5OCAoeG5pbnRyX2Nsb2NrX2hhbmRs
ZXIrMHhjYykKOnwgICMgZnVuYyAgICAgICAgICAgICAgICAgIDY5KyAgIDkuMDE0ICB4bnNj
aGVkX3BpY2tfbmV4dCsweDEwIChfX3hucG9kX3NjaGVkdWxlKzB4MTBjKQo6fCAgIyBmdW5j
ICAgICAgICAgICAgICAgICAgNzgrICAgMi44OTUgIGlwaXBlX3Vuc3RhbGxfcGlwZWxpbmVf
aGVhZCsweDEwIChfX3hucG9kX3NjaGVkdWxlKzB4MmY4KQo8fCAgKyBlbmQgICAgIDB4ODAw
MDAwMDAgICAgODEgICAgMi44MDUgIGlwaXBlX3Vuc3RhbGxfcGlwZWxpbmVfaGVhZCsweDhj
IChfX3hucG9kX3NjaGVkdWxlKzB4MmY4KQogfCAgKyBiZWdpbiAgIDB4ODAwMDAwMDEgICAg
ODQgICAgMC4wMDAgIF9feG5wb2Rfc2NoZWR1bGUrMHgzOTggKHhuaW50cl9jbG9ja19oYW5k
bGVyKzB4Y2MpCg==
--------------020601060309010103080909--

