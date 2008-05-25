MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18489.37081.181867.589790@domain.hid>
Date: Sun, 25 May 2008 18:16:25 +0200
In-Reply-To: <166743d9cab3b1b1bc8f3d29d9079afa@domain.hid>
References: <166743d9cab3b1b1bc8f3d29d9079afa@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] vxworks emulation
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

Matthieu wrote:
 > Hi,
 > 
 > I encounter a problem with the emulation of vxworks over Xenomai. I need to
 > use FUNCPTR but this function is't implemented the same in Xenomai as in
 > Wind River.

Defining:
typedef int             (*FUNCPTR) (...);
or
typedef int             (*FUNCPTR) ();     /* ptr to function returning int

defeats the compiler type checking. It is a really bad idea. In Xenomai
vxworks emulation, FUNCPTR is only used to mean a task function
pointer. When defining a funciont that will be used by other functions
than taskSpawn, simply define your function without declaring as a
FUNCPTR pointer, and everything will work.

-- 


					    Gilles.

