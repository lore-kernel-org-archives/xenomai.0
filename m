Message-ID: <508B9E60.9070404@xenomai.org>
Date: Sat, 27 Oct 2012 10:42:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BAY161-W175CDF0171545F77AAF931B67D0@phx.gbl>
In-Reply-To: <BAY161-W175CDF0171545F77AAF931B67D0@phx.gbl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Is there anybody who can compile the xenomai's
 user-space support libraries and tools statically?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: KangRobert <hseokkang@hotmail.com>
Cc: xenomai@xenomai.org

On 10/27/2012 07:38 AM, KangRobert wrote:

> 
> 
> Hi, I am trying to use xenomai with android platform.
> I tried to compile and install the skin libraries and testsuites on target board based by android platform.But It didn't work, because the android platform doesn't support GNU libc. 
> So now I'm trying to compile libraries statically, But It's very difficult to me.
> Is there anybody can help me?Please give me some hint.


When you configure xenomai user-space, you should pass --disable-shared
to the configure script, and pass "-static" in the CFLAGS variable.
Normally, that is all what is needed.

-- 
                                                                Gilles.

