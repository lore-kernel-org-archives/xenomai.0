Message-ID: <4991E562.3070200@domain.hid>
Date: Tue, 10 Feb 2009 21:36:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <187029.53861.qm@domain.hid>
In-Reply-To: <187029.53861.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] matching a kernel and xenomai patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: t02446@domain.hid
Cc: xenomai@xenomai.org

A User wrote:
> I see that Xenomai 2.4.6.1 supports Linux 2.6.27-x86-2.1-02, it's not
> clear exactly which Linux tar to start with.
> 
> I understand 2.6.27.  I can guess what x86 means, but I don't get
> 2.1-02.

It is the version of the patch, as it happens often that there are
several versions of adeos I-pipe patches for the same kernel.

> 
> 2.6.27 currently has build numbers up to 15 (that is, 2.6.27.15).  Do
> I use Xenomai 2.5.6.1 with Linux 2.6.27.15, or 2.6.27.2, or does
> 2.1-02 mean something else?  Is this covered in a faq?

The adeos I-pipe patch usually applies on any release. It happens that
it is false, in this case, a new patch is issued, called for instance:
adeos-ipipe-2.6.27.13-x86-2.2-04.patch, meaning that it works from linux
2.6.27.13 onward.

-- 
					    Gilles.

