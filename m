Message-ID: <527C7D70.9040401@siemens.com>
Date: Fri, 08 Nov 2013 06:58:08 +0100
From: Gernot Hillier <gernot.hillier@siemens.com>
MIME-Version: 1.0
References: <527BCB0B.1010609@siemens.com> <527BD057.3020708@xenomai.org>
In-Reply-To: <527BD057.3020708@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-forge PATCH] testsuite: fix clocktest
 invocation in xeno-test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Am 07.11.2013 18:39, schrieb Gilles Chanteperdrix:
> On 11/07/2013 06:16 PM, Gernot Hillier wrote:
>> As there are two testdir occurences in one line, we need global regex replace.
>
> This issue should have been fixed already.

In 2.6, yes. In -forge, no.

At least not according to 
http://git.xenomai.org/?p=xenomai-forge.git;a=tree;f=testsuite/xeno-test;h=6a795dc22461e375c55c9fb0504989443a12c17e;hb=HEAD

The patches I posted were all rebased to current -forge HEAD before posting.

-- 
Gernot

