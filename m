References: <7223c73f876d31388593.1481802442@devws148.be.alcatel-lucent.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2755589f-ad4d-a52d-8976-72222bc2eab2@xenomai.org>
Date: Thu, 15 Dec 2016 15:47:33 +0100
MIME-Version: 1.0
In-Reply-To: <7223c73f876d31388593.1481802442@devws148.be.alcatel-lucent.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] boilerplate: do not call xenomai_init 2 times
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 12/15/2016 12:47 PM, Ronny Meeus wrote:
> bootstrap.o is linked to the application code.
> In case the execution of the static constructors is postponed
> in the applicaion and the auto-init feature is used, the
> xenomai_init is called 2 times:
> - once in the path of the wrap_main
> - later in the context of the static constructor
> 

Why do you keep the auto-init feature on, given that you already control
the early init code by postponing the execution of the C++ ctors? I
would rather expect something like:

- build with no-auto-init
- call xenomai_init() manually from your entry point to activate the
Xenomai services when you see fit.
- call the ctor init chain.

-- 
Philippe.

