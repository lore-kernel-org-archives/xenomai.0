Message-ID: <517C5DD3.3060809@xenomai.org>
Date: Sun, 28 Apr 2013 01:22:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5176410F.1060100@gmail.com>
In-Reply-To: <5176410F.1060100@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai "does not" ISO C, C99 and C++ standard
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Victor Hiairrassary <victor.hiairrassary.ml@gmail.com>
Cc: xenomai@xenomai.org

On 04/23/2013 10:06 AM, Victor Hiairrassary wrote:

> Hello all,
> 
> We use xenomai 2.6.2.1 with g++ 4.7.2 from buildroot on a Armadeus apf27
> board. This works really fine, but if we add "-W -Werror -Wall -pedantic
> -pedantic-errors" in compiler command line, g++ detects some warnings for
> a code as simple as :
> 
> #include <native/task.h>
> int main() {
>      return 0;
> }
> 
> The complete log of the compilation is attached with this email.
> 
> The compiler complains about various things, in differents files. I have 
> not
> tested other xenomai's headers like native/queue.h, etc. yet.
> 
> Do you have any plans to fix them?


Hi Victor,

I have tried and fix this issue in Xenomai repository
(git://xenomai.org/xenomai-2.6.git), the errors disappeared completely
for the native and posix skins headers in C. The modifications made to
the posix headers for C do not seem to work for C++. It would be
interesting if you could download and try it.

Without "-pedantic-errors", including posix headers in a C++ program
simply triggers warning.

Regards.

-- 
                                                                Gilles.

