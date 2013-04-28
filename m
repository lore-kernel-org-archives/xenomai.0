Message-ID: <517D2017.9010307@xenomai.org>
Date: Sun, 28 Apr 2013 15:11:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5176410F.1060100@gmail.com> <517C5DD3.3060809@xenomai.org>
	<517D2E6B.3050601@gmail.com>
In-Reply-To: <517D2E6B.3050601@gmail.com>
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

On 04/28/2013 04:12 PM, Victor Hiairrassary wrote:

> On 04/28/2013 01:22 AM, Gilles Chanteperdrix wrote:
>> Hi Victor,
>>
>> I have tried and fix this issue in Xenomai repository
>> (git://xenomai.org/xenomai-2.6.git), the errors disappeared completely
>> for the native and posix skins headers in C. The modifications made to
>> the posix headers for C do not seem to work for C++. It would be
>> interesting if you could download and try it.
>>
>> Without "-pedantic-errors", including posix headers in a C++ program
>> simply triggers warning.
>>
>> Regards.
>>
> 
> Hello,
> 
> I have tried with these settings (board apf27 : arm imx27):
> 
> xenomai_ver = f60f1a4f758a7d9b010f39f439eb98240b7beb42
> xenomai_site = git://git.xenomai.org/xenomai-2.6.git
> buildroot: 2013.02
> gcc: 4.7.2
> libc: eglibc 2_12
> busybox: 1.21.0
> U-Boot: custom (2012.04)
> Linux: 2.6.38.8
> 
> I have tested a simple program (available in attached file compiler
> command lines and logs) in c90, c99, c++03 and c++11 standard.
> 
> Only c++11 have no warning !


You do not see the posix warnings because you are not compiling with
posix skin flags (xeno-config --skin posix --cflags)
c99 does not work for you for the same reason (you are not using the
flags provided by xeno-config).
I am not going to fix things more than that, I do not see why anyone
would want to compile with old standards like c90 or c++03
Regards.

-- 
                                                                Gilles.

