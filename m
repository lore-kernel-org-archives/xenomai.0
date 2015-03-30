Message-ID: <5519691A.7020009@xenomai.org>
Date: Mon, 30 Mar 2015 17:17:46 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t15m2dbUzGNxi4TsAVk4suZGc14qxv2cBh+iG1nWcM-kQ@mail.gmail.com>
 <55196828.9020207@xenomai.org>
In-Reply-To: <55196828.9020207@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] There is XDDP Sockets support in kernel?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/30/2015 05:13 PM, Philippe Gerum wrote:
> On 03/30/2015 04:55 PM, Helder Daniel wrote:
>> Hi,
>>
>> When trying to compile a kernel module that sets up a XDDP socket (code
>> snippet below) with Xenomai 3.x-rc3 on Cobalt setup,
>> rtdm_bind() returns ENOSYS.
>> This means that XDDP sockets can not be used in kernel?
>>
> 
> No, in this case it likely means that you are calling it from a
> real-time context (i.e. a real-time kthread started with
> rtdm_task_create()). The binding op can only run from a non-rt context,
> e.g. module init code, regular kthread context, _nrt handler.
> 

Please note that such restriction only applies to kernel-based callers.
When called from user-space via the bind() routine, Cobalt automatically
switches the caller to non-rt mode.

-- 
Philippe.

