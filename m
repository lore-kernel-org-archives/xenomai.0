References: <DB6PR0701MB2456788DAE300E14759F9646B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
 <2eb3cb3c-bbfd-32f1-0864-77749389813c@xenomai.org>
 <DB6PR0701MB24566C9B89E527ACFA283E03B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
 <DB6PR0701MB24562E69AA670D2EF605A322B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2fbb1509-b31f-f8e1-fa9e-e7ba0ff3f7f1@xenomai.org>
Date: Mon, 15 May 2017 12:55:15 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB24562E69AA670D2EF605A322B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_bind returns -EINVAL when not using
 --enable-smp
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/15/2017 12:47 PM, Giulio Moro wrote:
> Thanks for your response Philippe,
> 
>> --enable-smp in user-space entails no interaction with the kernel at
>> all, this is only a matter of issuing memory barriers in the code flow
>> to deal with lockless atomic sections.
> 
> still, is it expected that when not using --enable-smp my code fails?


Clearly not, since --disable-smp is the default configuration for the
arm architecture when configuring userland. I suspect a different issue.

-- 
Philippe.

