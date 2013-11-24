MIME-Version: 1.0
In-Reply-To: <5290FFA4.1040603@xenomai.org>
References: <CAKKWdtchCb5BeK4xLpEyUot5960Cx9HA87g+L=7UzQTfpyYsFg@mail.gmail.com>
 <5290FFA4.1040603@xenomai.org>
Date: Sun, 24 Nov 2013 08:24:52 -0500
Message-ID: <CAKKWdtdHQGL7C9ENXE6TVwPmPGcgsG+rqAqyqM3gF-vyjEnhMQ@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] a question about the Xenomai functionality when page
 fault exception
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

page fault exception is handled by the primary domain?

On 11/23/13, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 11/23/2013 04:16 PM, ali hagigat wrote:
>> If a Xenomai task is created , i think not all of the pages of that
>> task has been allocated inside the physical memory, so sooner or later
>> that task is faced with "page fault exception".
>
> You think wrong.
>
> --
>                                                                 Gilles.
>

