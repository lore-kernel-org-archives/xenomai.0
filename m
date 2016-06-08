References: <d00bbb2d634101853ccee292203bef44@smile.fr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ecbd6473-5c37-8e7e-582e-568cdec43269@xenomai.org>
Date: Wed, 8 Jun 2016 20:46:42 +0200
MIME-Version: 1.0
In-Reply-To: <d00bbb2d634101853ccee292203bef44@smile.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Activate a task with an alarm
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu KOWALEWSKI <matthieu.kowalewski@smile.eu>, xenomai@xenomai.org

On 06/08/2016 02:12 PM, Mathieu KOWALEWSKI wrote:
>  
> 
> Hey, 
> 
> I'm trying to create a alarm that can activate a alarm
> handler or a task ... 
> 
> But when my handler spawn a task, it returns an
> EINVAL error. 
> 
> I use Alchemy (Native) API and the Cobalt kernel on
> Xenomai 3.0.2 with x86 architecture. 
> 
> I don't know if it's an
> implementation will, to disallow the call of spawning/starting a task in
> an alarm handler, or just a bug. 

This is by design. An alarm handler is supposed to run time-critical
code. Creating new tasks is a heavyweight operation, which a dual kernel
system like Cobalt won't be able to carry out with real-time guarantees.

-- 
Philippe.

