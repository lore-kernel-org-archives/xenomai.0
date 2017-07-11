References: <20170711104133.4d12cfc7@md1em3qc>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <cd72619e-feeb-57f0-51dd-7c720b06596a@xenomai.org>
Date: Tue, 11 Jul 2017 11:45:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170711104133.4d12cfc7@md1em3qc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] secondary mode switches on rt_task_set_priority
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/11/2017 10:41 AM, Henning Schild wrote:
> Hi,
> 
> i was asked to assist debugging a case where a SIGXCPU is received
> after calling rt_task_set_priority. According to the docs that call
> should not cause secondary mode switches, but it seems it does.

This is a documented issue:
http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Scheduling

> Xenomai 3.0.5 kernel 4.4.43
> 
> I did not start digging yet but wanted to ask if someone has already
> come across that scenario.
> 

There is no work around with 3.0.x. There is a build option with the
upcoming 3.1 in -next called --enable-lazy-setsched, which defers the
priority update on the glibc-side until the target thread switches to
secondary mode.

-- 
Philippe.

