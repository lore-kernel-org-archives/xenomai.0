References: <56377A74.6020803@mail.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56377B55.8000600@xenomai.org>
Date: Mon, 2 Nov 2015 16:03:49 +0100
MIME-Version: 1.0
In-Reply-To: <56377A74.6020803@mail.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel oops in giveup_fpu (file fpu.S)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ralf Moder <ralf.moder@mail.de>, xenomai@xenomai.org

On 11/02/2015 04:00 PM, Ralf Moder wrote:
> Hi,
> 
> i have a powerpc cpu (mpc5200) running linux 3.14.17 with xenomai patch
> 2.6.4 on it. I use floating point in kernel, so the (assembly-)function
> "giveup_fpu" (in file arch/powerpc/kernel/fpu.S) is called and throws a
> kernel-oops. fpu.S is patched with ipipe-core-3.14.17-powerpc-6.patch.
> In original linux (kernel 3.14.17) "giveup_fpu" looks like this:
> 

Please send a diff context patch summarizing your changes.

-- 
Philippe.

