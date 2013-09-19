Message-ID: <523ADCBE.6000108@xenomai.org>
Date: Thu, 19 Sep 2013 13:15:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEk6gTC2n0iRT21RocjsChtsmz3u+q3b6hmyNb7c5Orj8Z605Q@mail.gmail.com>
In-Reply-To: <CAEk6gTC2n0iRT21RocjsChtsmz3u+q3b6hmyNb7c5Orj8Z605Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Disable documentation generation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Cc: xenomai@xenomai.org

On 09/19/2013 01:10 PM, Drasko DRASKOVIC wrote:
> Hi all,
> I am cross-compiling for ARM. How can I disable documentation generation?
> 
> I tried adding --disable-dox-doc --disable-dbx to ./configure, but I
> can still see doc generating during compilation (log below).

The log shows that the documentationn is installed, not generated. If
you do not want to install documentation, you can pass
--disable-doc-install.

Also note that the configure script has a --help option showing all its
options.

-- 
                                                                Gilles.

