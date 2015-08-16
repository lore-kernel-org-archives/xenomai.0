References: <55CF75CA.1010505@xenomai.org>
 <CAC-NLwxQnTo7xg5YmUYUqepnQbvgRiUXakRwqf+6b4VMMrDF9A@mail.gmail.com>
 <55D09565.8090800@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55D095FF.3010001@xenomai.org>
Date: Sun, 16 Aug 2015 15:54:07 +0200
MIME-Version: 1.0
In-Reply-To: <55D09565.8090800@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RELEASE] Xenomai 3.0-rc7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ashwin damle <ashwindamle@gmail.com>, Xenomai <xenomai@xenomai.org>

On 08/16/2015 03:51 PM, Philippe Gerum wrote:
> On 08/16/2015 03:48 PM, ashwin damle wrote:
>> Hi,
>>
>> Thought of reporting. I tried using the RC7. Can compile well, however,
>> while running the demo programs say xddp-label and others, I get an error
>>
>> *0"000.000| BUG in low_init(): [main] ABI mismatch: required r15, provided
>> r13*
> 
> http://xenomai.org/troubleshooting-a-dual-kernel-configuration/#incompatible_ABI_revision_level

i.e. while we refrain from changing the ABI between minor releases from
a stable version, this restriction does not apply to -rc releases.

-- 
Philippe.

