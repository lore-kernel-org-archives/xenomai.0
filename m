From: Jan Leupold <leupold@rsi-elektrotechnik.de>
Subject: XENO_OPT_DEBUG_MUTEX_SLEEP and serial drivers
Message-ID: <e2afc05d-6965-f5a1-700f-32d419156f5b@rsi-elektrotechnik.de>
Date: Wed, 27 May 2020 11:11:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hi,

it seems to me that the write() methods in 16550.c, mpc52xx_uart.c and
rt_imx_uart.c cause a SIGDEBUG when used on a kernel with
XENO_OPT_DEBUG_MUTEX_SLEEP set.

All drivers lock a mutex (named "out_lock") for the duration of these
functions and eventually call rtdm_event_timedwait() later - with the
mutex locked.

I think it is a good thing to serialize write() there, but it does not combine
well with the debug option. Currently I disable the test with
pthread_setmode_np() for the duration of write() in the application,
but maybe someone has a better idea how to deal with it.

Regards,

Jan



Mit freundlichen Grüßen

*Jan Leupold*
Entwicklung
Development
-- 
---------------------------------------------------------------------------
R-S-I Logo <https://www.rsi-elektrotechnik.de/>

R-S-I Elektrotechnik GmbH & Co. KG
Woelkestraße 11
D-85301 Schweitenkirchen
www.rsi-elektrotechnik.de <https://www.rsi-elektrotechnik.de/>

Tel: +49 8444 9204-32
Fax: +49 8444 9204-50
leupold@rsi-elektrotechnik.de <mailto:leupold@rsi-elektrotechnik.de>
---------------------------------------------------------------------------

Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363 Geschäftsführer:
Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg USt-IdNr.: DE 128592548


_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548


