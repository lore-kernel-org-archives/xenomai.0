Message-ID: <4D8892D4.4010701@domain.hid>
Date: Tue, 22 Mar 2011 13:15:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <846378.85636.qm@domain.hid>
In-Reply-To: <846378.85636.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with Posix Skin and RTnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Franz Engel <franz_lambert_engel@domain.hid>
Cc: xenomai@xenomai.org

Franz Engel wrote:
> Is there something wrong?

The way to compile applications for Xenomai posix skin is described here:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags

I do not know about cmake, but you should teach cmake to use xeno-config
to obtain the flags.

-- 
                                                                Gilles.

