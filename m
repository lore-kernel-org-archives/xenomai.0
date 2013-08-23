Message-ID: <5217B214.8020107@xenomai.org>
Date: Fri, 23 Aug 2013 21:03:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAP=r9tO8PueS5EX_ijQ4uE4oJnaXh1rMZ3T6uDdK=-LzLFH1cQ@mail.gmail.com>
In-Reply-To: <CAP=r9tO8PueS5EX_ijQ4uE4oJnaXh1rMZ3T6uDdK=-LzLFH1cQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xenomai i.MX6 cross-compilation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?0J/QsNGI0LAg0KHQtdGH0LrQvg==?= <bronetemkinponosec@gmail.com>
Cc: xenomai@xenomai.org

On 08/23/2013 10:47 AM, Паша Сечко wrote:
> I am trying to cross-compile a 3.0.35 linux kernel with some custom
> development patches for a i.MX6-based board. I've used ipipe-gch repository
> as a start point for my work, checked out to ipipe-3.0-imx6q branch,
> because it has some files and instructions to work with (arch/arm/mach-mx6
> and plat-mxc). I've added some board specific code to them and have
> redacted configs so they would compile, and after that I've used
> xenomai-2.6.1 release as it was said in the README.INSTALL file. Everything

Could you try again with 2.6.2.1 instead of 2.6.1?

-- 
                                                                Gilles.

