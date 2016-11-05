Date: Sat, 5 Nov 2016 18:22:16 +0000 (UTC)
From: Giulio Moro <giuliomoro@yahoo.it>
Message-ID: <698772021.248089.1478370136298@mail.yahoo.com>
In-Reply-To: <2ef2ba48-8598-eac0-b605-4372b39dd23e@hilscher.com>
References: <CAPdz0-x=sQMY-0DKYQX+PXjXM0br6eGm=Kyo_CrBPtwJndGfnA@mail.gmail.com>
 <20161104144806.GP1465@csclub.uwaterloo.ca>
 <2ef2ba48-8598-eac0-b605-4372b39dd23e@hilscher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Writing into files without mode switch
Reply-To: Giulio Moro <giuliomoro@yahoo.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=C3=A9phane_LOS?= <slos@hilscher.com>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, "Florian G." <florian.r.groeger@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>You could have a Linux process writing in your file data coming from 
>your RT process through IPC RT communication.

I have a question on this:
what IPC method would you recommend?
If I understand correctly, mode switches carry an overhead. If this is true, I guess is it reasonable to try to keep the non-RT thread in secondary mode. rt_pipe seems to be the only IPC method that does not force the non-RT task to switch to primary mode, but I am under the impression that using a pseudo-device may carry some overhead. Additionally, setting up a pipe is a bit cumbersome.
All considered, how does it compare performance-wise to other methods which require the non-RT task to continuously switch mode?
For IPC communication within the same Xenomai application, where one of the two threads needs to be in secondary mode, is it best to use rt_pipe or, e.g.: rt_queue?

Thanks,
Giulio

