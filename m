References: <37624ece.98b8.164b1962f83.Coremail.15084864580@163.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a192dc03-6374-d7bf-7b69-81c5f5276c8b@xenomai.org>
Date: Thu, 19 Jul 2018 12:24:47 +0200
MIME-Version: 1.0
In-Reply-To: <37624ece.98b8.164b1962f83.Coremail.15084864580@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai]
 =?utf-8?q?About_interrupting_pipeline_problems=EF=BC=9F?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: paper_tiger <15084864580@163.com>, xenomai@xenomai.org

On 07/19/2018 10:09 AM, paper_tiger wrote:
> Ipipe_post_irq_root(irq) does allow an interrupt to correspond to the xenomai domain and the linux domain respectively. But I want to verify the priority of the interrupt pipeline. What I wanted should be an interruption, first in the high-priority xenomai domain, then passed to the linux domain and then responded. Similar to the previous version of IPIPE_HANDLE_MASK | IPIPE_PASS_MASK. But what should I do with the current version of ipipe. 

You should read my previous answer carefully.

-- 
Philippe.

