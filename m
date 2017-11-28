From: Philippe Gerum <rpm@xenomai.org>
References: <db1d3f66-4afb-4771-1b62-a45164474991@xenomai.org>
 <1e290f53-5724-c9ed-c2ed-72e7bf422142@xenomai.org>
Message-ID: <1c4d3935-801e-43ba-7802-fe9c5ef88f3c@xenomai.org>
Date: Tue, 28 Nov 2017 10:24:19 +0100
MIME-Version: 1.0
In-Reply-To: <1e290f53-5724-c9ed-c2ed-72e7bf422142@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Improving the documentation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 11/26/2017 04:34 PM, Philippe Gerum wrote:
> On 11/25/2017 10:59 PM, Philippe Gerum wrote:
>>
>> As mentioned multiple times already, the documentation (or lack of
>> thereof) is an important issue with the project.
>>
>> In order to help fixing it, I encourage you to suggest topics and
>> technical details you would like to see documented. This would give
>> hints about what needs to be done in this area to people willing to
>> contribute.
>>
>> Given the amount of work ahead, I would recommend to document the
>> current Xenomai 3.x series exclusively for now, not 2.x which is EOL.
>>
>> Here is a bulk of topics which it may be useful to cover, I once
>> mentioned on this mailing list:
>>
>> On 06/11/2017 07:06 PM, Philippe Gerum wrote:
>>> - IPC between Cobalt and the regular world
>>> - Sessions: sharing objects between processes within a UN*X group
>>> - Driving a DMA with Cobalt
>>> - Practical example of using slackspot (fixing it if necessary).
>>> - How to create a user-space driver with UDD
>>> - Survival kit when debugging a boot hang with Cobalt
>>> - Who lives in /proc/xenomai after all?
>>> - SCHED_WEAK, SCHED_QUOTA, SCHED_TP, SCHED_SPORADIC... What do all
>> those Cobalt schedulers do?
>>> - Sharing IRQs between Linux and Cobalt considered funky.
>>> - Why and how calling Linux services within a real-time loop may kill
>>> the latencies?
>>> - Solving the C++ constructor madness when that code requires Xenomai
>>> core services, a 10 years long psychotherapy
>>
>> We have a so-called knowledge base [1] available from the web site.
>> This base is supposed to host application notes, technical articles
>> about selected Xenomai features or areas. This knowledge base never grew
>> as it should have. A good way to improve the situation would be to
>> populate it.
>>
>> If you need explanations, to clarify some technical details about a
>> topic you would like to document, please ask on the list.
>>
>> Currently, notes should be written in asciidoc format [2] (one text file
>> per article), which is a fairly simple markup language. The publishing
>> infrastructure at xenomai.org - which updates the website based on the
>> contents of the documentation repository - depends on this. At any rate,
>> asciidoc is much easier to deal with than Doxygen, which is currently
>> used for the inline API docs.
>>
>> I will make the existing notes available from a public git tree in the
>> coming days. Updates, improvements to this material are welcome as well.
>>
>> Thanks,
>>
>> [1] https://xenomai.org/knowledge-base-index/
>> [2] http://www.methods.co.nz/asciidoc/
>>
> 
> The source form of the technical articles currently visible at [1] can
> be pulled as follows:
> 
> git clone git://xenomai.org/xenomai-kbase.git
> 
> You can send any update or new article to the mailing list. I'm also
> open to giving write access to the repository to people who are willing
> to contribute on a regular basis to this task.


I just added various guides there. All the documentation material
available from the website is now available in the xenomai-kbase repository.

-- 
Philippe.

