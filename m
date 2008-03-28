Message-ID: <2ff1a98a0803280605j43811112y1c29e61edd0bc53c@domain.hid>
Date: Fri, 28 Mar 2008 14:05:28 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150803280435s2fb6a459kcfe68a0dde86b34c@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150803280435s2fb6a459kcfe68a0dde86b34c@domain.hid>
Subject: Re: [Xenomai-help] Using shared memory, Xenomai 2.4.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Fri, Mar 28, 2008 at 12:35 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
>  Also, I've enable during kernel compilation in posix skin option
>  'shared memory'. Also, I tried with posix skin in user space:
>  [..]
>  fd = shm_open ("MainSHM", O_RDWR, 0);
>  [..]
>
>  When I start it, on the console I can see:
>  shm_open: No such file or directory
>  Xenomai: POSIX: destroyed thread c4802400

Native and POSIX shared heap namespaces are separated. To create a
shared heap for communications between kernel-space and user-space
using posix interface, you have to pass O_CREAT to shm_open on either
side.

-- 
 Gilles

