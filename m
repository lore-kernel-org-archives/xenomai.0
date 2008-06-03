Message-ID: <2ff1a98a0806030233g2a6a0da4r21cd3e904c73354b@domain.hid>
Date: Tue, 3 Jun 2008 11:33:46 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1f07a70261f8968ea5127230d3bca636@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1f07a70261f8968ea5127230d3bca636@domain.hid>
Subject: Re: [Xenomai-help] VxWorks problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

On Tue, Jun 3, 2008 at 11:20 AM, Matthieu
<matthieu.connaulte_xenomai@domain.hid> wrote:
> Hi,
>
> I still have problems with the use of vxworks emulation. Indeed I need to
> lock interrupt ( intLock() and intUnLock() ) in order to manipulate a tas=
> ks
> control blocks table. But I'm in user space ... what can I do ?

Use a mutex.

-- 
 Gilles

