Message-ID: <4FC637EB.90908@xenomai.org>
Date: Wed, 30 May 2012 17:08:27 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtc6Py7A9YuJ1nNzwmq0SiEcrP_D8pztoo_eNWsp9EAsFg@mail.gmail.com>
In-Reply-To: <CAKKWdtc6Py7A9YuJ1nNzwmq0SiEcrP_D8pztoo_eNWsp9EAsFg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] a question about ADEOS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 05/30/2012 04:35 PM, ali hagigat wrote:
> I know that adeos project presents an API set. It means some functions
> mostly which start with adeos_.
> Why adeos patch does not add them to the linux kernel?

I don't understand your question.

Those functions
> are used for creating domains as far as I know.
> So maybe they are not needed for xenomai, is that true?

No, we do use them to create a real-time domain where Xenomai lives.

  So in Xenomain
> project all the software components have the same domain?
>

No.

> My another question is about i-pipe concept of ADEOS. What is that?
> can any one explain it? Is it a queue?
>

I-pipe means interrupt pipeline, i.e. what "Adeos" implements at its 
core. Adeos == I-pipe == interrupt pipeline, same thing.

> Thank you all for reading this message.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

