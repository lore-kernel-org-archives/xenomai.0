Message-ID: <4EA53A99.1050305@domain.hid>
Date: Mon, 24 Oct 2011 12:14:49 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] some problems with interrupts
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

i installed the patch 'adeos-ipipe-2.6.31-arm-1.16-02.patch' on a kernel 
2.6.31 for imx257 processor.
I have a xenomai complex application that read touchscreen events with 
tslib when pressed.
In the kernel log i try these lines: ( the read job is made in a 
not-realtime thread )

------------[ cut here ]------------
WARNING: at drivers/input/touchscreen/mxc_tsc.c:599 
mxc_tsc_interrupt+0x19c/0x30c [mxc_tsc]()
Modules linked in: can_raw can flexcan sdhci_mxc ehci_hcd mmc_core 
usbcore mxc_tsc nls_base
Backtrace:
[<c0028150>] (dump_backtrace+0x0/0x114) from [<c02c9a48>] 
(dump_stack+0x18/0x1c)
  r7:bf0054bc r6:00000257 r5:bf0046d8 r4:00000000
[<c02c9a30>] (dump_stack+0x0/0x1c) from [<c0043390>] 
(warn_slowpath_common+0x50/0x68)
[<c0043340>] (warn_slowpath_common+0x0/0x68) from [<c00433c0>] 
(warn_slowpath_null+0x18/0x1c)
  r7:0000002e r6:00000001 r5:00008013 r4:d1959400
[<c00433a8>] (warn_slowpath_null+0x0/0x1c) from [<bf0046d8>] 
(mxc_tsc_interrupt+0x19c/0x30c [mxc_tsc])
[<bf00453c>] (mxc_tsc_interrupt+0x0/0x30c [mxc_tsc]) from [<c007242c>] 
(handle_IRQ_event+0x3c/0x124)
  r7:0000002e r6:00000000 r5:00000000 r4:d1c69840
[<c00723f0>] (handle_IRQ_event+0x0/0x124) from [<c007466c>] 
(handle_level_irq+0x98/0x12c)
  r7:0000002e r6:d1c69840 r5:0000002e r4:c0399b70
[<c00745d4>] (handle_level_irq+0x0/0x12c) from [<c0023070>] 
(_text+0x70/0x8c)
  r7:0000002e r6:c03fc240 r5:00000000 r4:0000002e
[<c0023000>] (_text+0x0/0x8c) from [<c0076ee8>] 
(__ipipe_sync_stage+0x180/0x268)
Exception stack(0xc038ff40 to 0xc038ff88)
ff40: 00000020 00000004 c03fc264 fffffffd 00000000 ffffffff 00000001 
c038e000
ff60: c039d540 c0392418 c03b7444 8001f200 41069264 8001f1cc c038ff94 
c038ff88
ff80: c0077770 c0076d78
  r5:c039d508 r4:c03fc260
[<c0076d68>] (__ipipe_sync_stage+0x0/0x268) from [<c0077770>] 
(__ipipe_unstall_root+0x3c/0x50)
[<c0077734>] (__ipipe_unstall_root+0x0/0x50) from [<c00257a8>] 
(cpu_idle+0x64/0xcc)
[<c0025744>] (cpu_idle+0x0/0xcc) from [<c02c6eb0>] (rest_init+0x78/0x8c)
  r7:c0392410 r6:c0020e14 r5:c0020e18 r4:c038e000
[<c02c6e38>] (rest_init+0x0/0x8c) from [<c00089a4>] 
(start_kernel+0x284/0x2e0)
  r5:c0020e18 r4:c0410190
[<c0008720>] (start_kernel+0x0/0x2e0) from [<80008034>] (0x80008034)
  r5:c03b74cc r4:00053175
---[ end trace c83bf7139f281ac6 ]---
mx25-tsc mx25-tsc: mxc_tsc_read_ts: Failed to get data

Do you know the meaning in xenomai of this error (so i can modify 
something to resolve the problem )?

Thanks a lot


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


