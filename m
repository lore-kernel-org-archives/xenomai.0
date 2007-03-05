Message-ID: <45EBE903.6090202@domain.hid>
Date: Mon, 05 Mar 2007 10:55:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Porting GNU/Linux to Xenomai
References: <38b44d590703041116o25fdab82jf2a53739c97a20fd@domain.hid>
In-Reply-To: <38b44d590703041116o25fdab82jf2a53739c97a20fd@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saiful Khan <saiful.etc@domain.hid>
Cc: xenomai@xenomai.org

Saiful Khan wrote:
> Hello,
> 
> I have a normal GNU/Linux (Linux System Programming) application,
> running on Linux properly. But due to some performance related issue. I
> have installed Xenomai Linux with RTNet. And now I want this application
> to run under xenomai with highest priority so that I can get the desired
> real-time performance.
> The application is little large consist of message queue, shared memory,
> socket and several threads. Can you please suggest me :
> what are the changes I need to do in the application?
> Can I run the same application in xenomai (using the RTNet) without any
> change?
> Or  If I need to change what skin I have to prefer (POSIX/Native)?
> I need to run it in user space or kernel space?
> 
> Please suggest me the simple way, what can I do to port the GNU/Linux
> application in Xenomai using the RTNet?

If the application you have to port already uses the posix API, the
simple way to port it to xenomai is to use the posix skin. Using xenomai
posix skin is just a matter of using xeno-config in order to set
correctly the compilation flags, you should have a look at
ksrc/skins/posix/demos for details.

Note however that only setting the compilation flag will not magically
turn the application into a real-time application, you will have to
inspect your application to find what exactly must be done in a high
priority task, and in these high priority task, you will have to use
only real-time services in order to avoid loosing determinism.

About RTnet, note that you will only get deterministic UDP, TCP can not
be made deterministic.

About the user-space/kernel-space choice, you should start using
user-space as much as possible, except for drivers code. If you do not
get enough determinism, you will then have the freedom to move some
parts to kernel-space.

-- 
                                                 Gilles Chanteperdrix

