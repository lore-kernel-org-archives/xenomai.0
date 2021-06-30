Sender: chensong_2000@189.cn
Subject: Re: [PATCH 0/2] [florian/y2038] try to acquire mutex before checking
 timeout
References: <1625034666-29093-1-git-send-email-chensong_2000@189.cn>
 <407b20a26e7d88db2a84efa2ff5fb3e42f039446.camel@siemens.com>
From: "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <ad5c03fb-e3b9-acb6-583c-1852a4f080a2@189.cn>
Date: Wed, 30 Jun 2021 14:54:01 +0800
MIME-Version: 1.0
In-Reply-To: <407b20a26e7d88db2a84efa2ff5fb3e42f039446.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>



在 2021/6/30 下午2:38, Bezdeka, Florian 写道:
> Hi Song,
> 
> On Wed, 2021-06-30 at 14:31 +0800, Song Chen wrote:
>> This patch serial is going to change mutex_timedlock's behavior, instead of
>> validating timeout first, it tries to acquire resource at the beginning and
>> returns 0 if resource is available even timeout is invalid.
>>
>> smokey test for mutex should be adjusted regarding the change.
>>
>> Song Chen (2):
>>    y2038: cobalt/posix/mutex: try acquire mutex before checking timeout
>>    y2038: testsuite/smokey/2038: move mutex test to another thread
> 
> This has nothing to do with the y2038 stuff, so I would vote for
> removing that from the title.

should i resend the patch serial? it has something to do with smokey test.

/Song
> 
>>
>>   kernel/cobalt/posix/mutex.c            |  5 +++
>>   testsuite/smokey/y2038/syscall-tests.c | 74 +++++++++++++++++-----------------
>>   2 files changed, 41 insertions(+), 38 deletions(-)
>>
> 

