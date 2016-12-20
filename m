References: <a9bb92d8-5e99-7afe-4381-7fad371632d0@smile.fr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <21e6332e-1acf-d53e-3ad5-543ff548a3a5@xenomai.org>
Date: Tue, 20 Dec 2016 12:23:48 +0100
MIME-Version: 1.0
In-Reply-To: <a9bb92d8-5e99-7afe-4381-7fad371632d0@smile.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __COBALT_SYSCALL_BIT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Stephan <julien.stephan@smile.fr>, xenomai@xenomai.org

On 12/20/2016 11:12 AM, Julien Stephan wrote:
> Hello,
> 
> Is it safe to change __COBALT_SYSCALL_BIT from 0x10000000 to 0x700 ?
> Or it may broke some xenomai functionnalities?
> 
> I need to do that, because the ISA of my architecture specifies that the
> scall number should be on 12 bits... It is not compiling otherwise..
> 

I still don't know which architecture you are talking about, so I can't
answer questions about porting Xenomai to it.

-- 
Philippe.

