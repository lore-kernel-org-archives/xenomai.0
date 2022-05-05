MIME-Version: 1.0
References: <AM7P122MB022978CBCF4698031D9E1F33F2C29@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
In-Reply-To: <AM7P122MB022978CBCF4698031D9E1F33F2C29@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 5 May 2022 18:58:18 +0200
Message-ID: <CAFLxGvxUFD4qRvESTfO4pHHshJV35FFOcf15-HDbKSSAQ2m_rw@mail.gmail.com>
Subject: Re: Can't compile userspace application with compiler switch
 -std=c++11 and Xenomai 3.2
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Grau, Gunter" <gunter.grau@philips.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, May 5, 2022 at 4:56 PM Grau, Gunter via Xenomai
<xenomai@xenomai.org> wrote:
>
>
> Hi,
>
> We are trying to port our application to Xenomai 3.2.
> The source is c++ and we use in some parts C++11 elements. Therefore the compile switch is set to -std=c++11.

Since Xenomai uses GNU extensions you need to use -std=gnu++11 instead
of -std=c++11.

-- 
Thanks,
//richard

