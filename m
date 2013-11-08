Message-ID: <527CF7D6.2050202@xenomai.org>
Date: Fri, 08 Nov 2013 15:40:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <527BCB0B.1010609@siemens.com> <527BD057.3020708@xenomai.org>
 <527C7D70.9040401@siemens.com>
In-Reply-To: <527C7D70.9040401@siemens.com>
Content-Type: text/plain; charset=UTF-8
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
To: Gernot Hillier <gernot.hillier@siemens.com>
Cc: xenomai@xenomai.org

On 11/08/2013 06:58 AM, Gernot Hillier wrote:
> Am 07.11.2013 18:39, schrieb Gilles Chanteperdrix:
>> On 11/07/2013 06:16 PM, Gernot Hillier wrote:
>>> As there are two testdir occurences in one line, we need global regex replace.
>>
>> This issue should have been fixed already.
> 
> In 2.6, yes. In -forge, no.

See commit 7e4b15dfae125f1d90719b4ed0ca1208c35c1b06

-- 
                                                                Gilles.

