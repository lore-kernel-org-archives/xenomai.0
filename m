Subject: Re: smokey's fork tests hangs with glibc 2.28+ ?
References: <c57ea289db8a425da4d09d89d0de5d96@andritz.com>
 <76f0e9a2-f783-df4f-d736-4f0e246d44c2@siemens.com>
 <f6c647a090744868b23a138ad213e96c@andritz.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b9e0b39a-e3e9-f99e-eb44-a1e8ddf34aae@xenomai.org>
Date: Mon, 11 Mar 2019 15:19:00 +0100
MIME-Version: 1.0
In-Reply-To: <f6c647a090744868b23a138ad213e96c@andritz.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 3/11/19 3:08 PM, Lange Norbert via Xenomai wrote:
> Thats a rootfs which reproduces the issue. Identical setup, but glibc 2.27 will not reproduce.

The issue was introduced by [1], which already triggered a bug in the
glibc test suite [2]. In short, calling pthread_atfork() like
__cobalt_init() does over the context of a fork handler is now invalid,
because the glibc now holds the internal atfork_lock while running the
fork handlers. The cobalt fork handler needs to be registered earlier,
outside of such context.

This change was introduced between glibc-2.27.9000 and glibc-2.28.

[1] git://sourceware.org/git/glibc.git, 27761a104
[2] git://sourceware.org/git/glibc.git, 669ff911e

-- 
Philippe.

