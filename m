Message-ID: <9c789a000811160611h6658153ao32f643c8fda1af5b@domain.hid>
Date: Sun, 16 Nov 2008 16:11:49 +0200
From: "Cristian Axenie" <cristian.axenie@domain.hid>
In-Reply-To: <9c789a000811131546j367ad76fk7d05a21848b18bd@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_29192_26151200.1226844709168"
References: <9c789a000811080850q47f5b429k130fff3f64985aa3@domain.hid>
	<200811112339.39637.berlemont.hauw@domain.hid>
	<9c789a000811120035v374914f1t84ff879be1fb9bb4@domain.hid>
	<200811130038.31617.berlemont.hauw@domain.hid>
	<9c789a000811121606o252070a7y96c94d4505f8ace6@domain.hid>
	<9c789a000811121645u2f81dd6fode1fe681f9c75a31@domain.hid>
	<9c789a000811131546j367ad76fk7d05a21848b18bd@domain.hid>
Subject: Re: [Xenomai-help] SegFault on all multiple apps!!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org, rpm@xenomai.org

------=_Part_29192_26151200.1226844709168
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,
I finally managed to solve the SegFault problem, so the thread should be
closed.

 I've created a root filesystem on my USB Flash stick where I added the
xenomai dir (including /bin /lib /include...) generated during the Xenomai
(from the trunk) install and also the devices rtheap rtp0... in the /dev
directory of my FS. I also used the proper libc-2.6 standard shared
libraries so the dynamic linker does't send a SIGSEGV anymore and  I am able
now to run ./latency or ./cyclictest (altough I'm not really sure if the
results are proper !). I don't receive SegFault anymore.

But a problem when running ./cmd_write I get :
    cmd_write: comedi_get_chinfo failed (ret=-22)
So it cannot find any channel info , so is it possible that an error ocured
when loading a specific file descriptor??

I also would like to check somehow the validity of my Xenomai and Comedi
installation. Is it possible to do this ??

Best regards ,
Cristian

------=_Part_29192_26151200.1226844709168
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all, <br>I finally managed to solve the SegFault problem, so the thread should be closed.<br><br>&nbsp;I&#39;ve created a root filesystem on my USB Flash stick where I added the xenomai dir (including /bin /lib /include...) generated during the Xenomai (from the trunk) install and also the devices rtheap rtp0... in the /dev directory of my FS. I also used the proper libc-2.6 standard shared libraries so the dynamic linker does&#39;t send a SIGSEGV anymore and&nbsp; I am able now to run ./latency or ./cyclictest (altough I&#39;m not really sure if the results are proper !). I don&#39;t receive SegFault anymore. <br>
<br>But a problem when running ./cmd_write I get :<br>&nbsp;&nbsp;&nbsp;
cmd_write: comedi_get_chinfo failed (ret=-22)<br>So it cannot find any channel info , so is it possible that an error ocured when loading a specific file descriptor??<br><br>I also would like to check somehow the validity of my Xenomai and Comedi installation. Is it possible to do this ??<br>

<br>Best regards ,<br>Cristian <br>

------=_Part_29192_26151200.1226844709168--

