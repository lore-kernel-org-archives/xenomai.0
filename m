Message-ID: <4FFFD02B.7020202@xenomai.org>
Date: Fri, 13 Jul 2012 09:37:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1342097120.22964.YahooMailNeo@web120604.mail.ne1.yahoo.com>	<4FFED232.60506@xenomai.org>
	<CAAEqEhH_TKjC0wRtx8uT2kQWbRESHrJkYrxPg095FZ1bvi-+6A@mail.gmail.com>
In-Reply-To: <CAAEqEhH_TKjC0wRtx8uT2kQWbRESHrJkYrxPg095FZ1bvi-+6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.0 installation Error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ilesh patel <patelilesh32@gmail.com>
Cc: xenomai@xenomai.org

On 07/13/2012 07:51 AM, Ilesh patel wrote:
> Hello,
> 
> Thank you for your kind reply
> 
> I understand the error.
> 
> I read the README file in /arch/x86/patches/  The README file shows
> "Xenomai supports the x86_64,x86 architecture starting with the v2.6
> Linux kernel series." and my krenel is V2.6.32-generic.

Ok, even if the README file is short, you seem not patient enough to
read it. Some I am going to quote the relevant parts:

"This support is provided by the interrupt pipeline (aka I-pipe) in the
form of a kernel patch you have to apply against a VANILLA kernel
tree, before you attempt to compile the Xenomai codebase against the
latter kernel.

Apply one of the patches found into this directory against the
CORRESPONDING kernel release."

So: for a vanilla 2.6.32 kernel, you have to use a patch with 2.6.32 in
the name. And the patch will apply only to a vanilla kernel, for any
other kernels, it will not necessarily apply.

Please no private mail.

-- 
                                                                Gilles.

