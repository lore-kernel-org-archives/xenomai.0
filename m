Message-ID: <49803BC1.6080101@domain.hid>
Date: Wed, 28 Jan 2009 11:04:33 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <D6F368154C2B1043938B495AE13F245B06F76F43@domain.hid>
In-Reply-To: <D6F368154C2B1043938B495AE13F245B06F76F43@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Stability problems with Xenomai install
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Edward Robbins <Edward.Robbins@domain.hid>
Cc: xenomai@xenomai.org

Edward Robbins wrote:
> My .config is attached

Try and remove:
CONFIG_X86_PM_TIMER=y
CONFIG_PCI_MSI=y
CONFIG_AUDITSYSCALL=y
CONFIG_ASYNC_MEMCPY=m

-- 
                                                 Gilles.

