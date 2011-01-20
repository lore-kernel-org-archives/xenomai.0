Date: Thu, 20 Jan 2011 20:22:33 +0100 (CET)
From: "Waschk,Kolja" <xenoka09@domain.hid>
In-Reply-To: <4D38886F.7060802@domain.hid>
Message-ID: <alpine.DEB.2.00.1101202018180.2425@domain.hid>
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid>
	<alpine.DEB.1.10.1101201811090.1990@domain.hid>
	<4D387148.3030306@domain.hid>
	<alpine.DEB.2.00.1101201943440.2425@domain.hid>
	<4D38886F.7060802@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

> you sure this is the "try" program for which you sent the sources? I do

Yes.

> not understand the references to shm_open, shm_unlink, for instance.

Somewhat strange, indeed. From the longer output of objdump -D, I conclude that
shm_open and shm_unlink code (a few assembly words) is contained in the binary,
but not called from anywhere in the remaining code within "try".

Kolja


-- 
mr. kolja waschk - haubach-39 - 22765 hh - germany
fon +49 40 889130-34 - fax -35 - http://www.ixo.de


