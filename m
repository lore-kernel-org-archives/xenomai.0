MIME-Version: 1.0
In-Reply-To: <52D69428.4020806@xenomai.org>
References: <CAKKWdtf9Z+nEz85-HbX6u5k2X1uBQBEP-rA9yDY9-+japs9M6Q@mail.gmail.com>
 <52D69428.4020806@xenomai.org>
Date: Mon, 20 Jan 2014 02:48:58 -0500
Message-ID: <CAKKWdteE=_pRH6JR0Mkq3dV4DVx87sPct3JsQ0SQft5=ad8eYg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] a test for T_HOOK_SWITCH
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

I will do that. but the 2 extra lines printed seem incorrect. as far
as i understood, T_HOOK_SWITCH is called for every rt_task_resume()...

On 1/15/14, Philippe Gerum <rpm@xenomai.org> wrote:
> On 01/15/2014 02:44 PM, ali hagigat wrote:
>> Why the first and last lines are printed as seen in output.txt?
>
> Why don't you check the return codes of the API calls?
>
> --
> Philippe.
>

