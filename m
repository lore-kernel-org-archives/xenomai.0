MIME-Version: 1.0
In-Reply-To: <4FC637EB.90908@xenomai.org>
References: <CAKKWdtc6Py7A9YuJ1nNzwmq0SiEcrP_D8pztoo_eNWsp9EAsFg@mail.gmail.com>
	<4FC637EB.90908@xenomai.org>
Date: Tue, 5 Jun 2012 10:56:04 +0430
Message-ID: <CAKKWdte3jE_kW8esz25=gYeYU_M1cmOmftgbfMs9RqyfBCr9Kw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] a question about ADEOS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Much appreciates for the replies.

if you look at the following page:

http://home.gna.org/adeos/doc/api/globals.html

You can see some functions like adeos_alloc_irq() or adeos_alloc_ptdkey().

But if you patch the linux kernel with the adeos patch, these
functions do not exist.



On Wed, May 30, 2012 at 7:38 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 05/30/2012 04:35 PM, ali hagigat wrote:
>>
>> I know that adeos project presents an API set. It means some functions
>> mostly which start with adeos_.
>> Why adeos patch does not add them to the linux kernel?
>
>
> I don't understand your question.
>
>
> Those functions
>>
>> are used for creating domains as far as I know.
>> So maybe they are not needed for xenomai, is that true?
>
>
> No, we do use them to create a real-time domain where Xenomai lives.
>
>

