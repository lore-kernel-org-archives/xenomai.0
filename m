Message-ID: <531D6083.3030006@xenomai.org>
Date: Mon, 10 Mar 2014 07:49:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFNBftdTVXFwu5OjMML0R7GJTXDQricBYACkV_HmQmf9Rv6DDg@mail.gmail.com>
In-Reply-To: <CAFNBftdTVXFwu5OjMML0R7GJTXDQricBYACkV_HmQmf9Rv6DDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Build Xenomai Lib native on the Beaglebone Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Cc: xenomai@xenomai.org

On 03/10/2014 04:00 AM, Flavio Castro Alves Filho wrote:
> Hello,
> 
> Does anybody tried to build the Xenomai user space native on a BeagleBone Black?
> 
> I'm using Debian on my board, with the build-essential package installed.

If you do not use xenomai 2.6 git, you will probably need this patch:
http://git.xenomai.org/xenomai-2.6.git/commit/?id=b10527ed14399a6485f69b935988d9d5211066d0

to allow compiling xenomai for the armhf flavor of debian.

> 
> Should we have the same result as cross-compiling?

With the same versions of the tools, you should have exactly the same result. 
Only, you will probably get it after some more time.

Regards.

-- 
                                                                Gilles.

