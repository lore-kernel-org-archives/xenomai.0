Message-ID: <524E9225.1000102@xenomai.org>
Date: Fri, 04 Oct 2013 12:02:13 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAAXf6LUfHA9aHe2FRngFJSKVXeKPVwxGLcRPYGNBqd7U1dMzKg@mail.gmail.com>
In-Reply-To: <CAAXf6LUfHA9aHe2FRngFJSKVXeKPVwxGLcRPYGNBqd7U1dMzKg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-forge: multiple COPYING files
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thomas De Schampheleire <patrickdepinguin+xenomai@gmail.com>
Cc: xenomai@xenomai.org

On 10/02/2013 01:42 PM, Thomas De Schampheleire wrote:
> Hi,
>
> The (L)GPL requires that every distribution of a derived work is
> accompanied with the license of the program (xenomai-forge).
> Currently, xenomai-forge contains several COPYING files:
>
> ./kernel/cobalt/nucleus/COPYING
> ./kernel/cobalt/COPYING
> ./kernel/cobalt/rtdm/COPYING
> ./include/COPYING
> ./lib/alchemy/COPYING
> ./lib/psos/COPYING
> ./lib/vxworks/COPYING
> ./lib/analogy/COPYING
> ./lib/cobalt/COPYING
> ./lib/copperplate/COPYING
>
> An embedded build system like buildroot [1] has legal-info facilities
> to mark for each package which license it uses, and where the license
> files is located. A user can easily generate an overview of the
> license information for all packages used in the system, and contains
> almost everything necessary to comply with the (L)GPL. In buildroot,
> this is done with 'make legal-info'.
>
> In the case of buildroot, the license files are copied one by one in a
> directory named after the package. This would essentially mean:
> cp <xenomai-source>/kernel/cobalt/nucleus/COPYING licenses/xenomai/COPYING
> cp <xenomai-source>/kernel/cobalt/COPYING licenses/xenomai/COPYING
> cp <xenomai-source>/kernel/cobalt/rtdm/COPYING licenses/xenomai/COPYING
> ...
>
> Clearly, the fact that all license files have the same name poses a
> problem here. In order to have all files, one would either need to
> rename them, or duplicate the directory structure.
>
> Instead of moving this complexity outside of xenomai-forge (to the
> build system), I would like to discuss how it can be solved within
> xenomai-forge itself.

Well, using the position in the file system hierarchy as a mean to 
disambiguate issues by giving them a specific scope is quite common. The 
fact that buildroot can only cope with a flat namespace for licenses, 
does not mean that any package buildroot integrates should agree or even 
bother.

>
> Here are two proposals:
> 1. Is it really necessary that there are multiple COPYING files? Is it
> not possible to have one COPYING file in the root of the project, and
> move the exception specified in include/COPYING to that file? This
> approach is similar to many many other open-source projects.

Having the exception clause present in one particular file has a reason: 
the legalese there is very much scoped, I didn't want it to apply to any 
other part of the sources I once wrote. For this reason, moving it to 
the toplevel would not make sense.

This said, such clause is on its way out though, after the recent 
introduction of the LGPLd uapi/ header area, for sharing definitions 
between kernel and userland.

 > 2. Alternatively, what about renaming the license files to a unique
 > name, e.g. COPYING.alchemy, COPYING.psos, COPYING.cobalt-nucleus ?
 > Then, copying these files to one directory is possible without 
overwriting.

Specifically, I would certainly not rename anything to COPYING.psos or 
to whatever established trademark. Generally speaking, I'm not fond of 
the idea of working around a buildroot shortcoming by reshuffling 
headers or renaming them all through the Xenomai tree. I'll have to 
meditate on this when I'm not grumpy.

-- 
Philippe.

