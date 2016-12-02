References: <CAMJ=MEdM7O5OBjpQV8sYyVfpToJbuy24MMfDRouDeMaryGcR+g@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7bcf3d70-494c-9fa1-8554-f746ef130b7c@xenomai.org>
Date: Fri, 2 Dec 2016 15:01:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEdM7O5OBjpQV8sYyVfpToJbuy24MMfDRouDeMaryGcR+g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai]
 =?utf-8?q?Question_about_config_option_=E2=80=93mem-poo?=
 =?utf-8?q?l-size?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 12/02/2016 02:03 PM, Ronny Meeus wrote:
> Hello
> 
> Context: I'm using the pSOS interface over the Mercury core (version 3.0.3).
> 
> I have a question about option:
> –mem-pool-size
> described on page
> http://xenomai.org/2015/05/application-setup-and-init/
> 
> Is the parameter specifying the maximum size that will be used Xenomai
> or is this the initial value that will be used while creating the main
> memory pool.
> 
> The explanation makes me think it is the first case while tests show
> that it is the
> latter case. e.g. the memory pool just extends when it is depleted.
>

How do you check this?

> To me it would make more sense that the parameter is specifying the maximum
> memory that will be used since like it is today the application's
> memory usage can
> grow until all system memory is consumed.
> 

As stated in the documentation, this parameter configures the size of
the memory area underlying the the main/session heap, which is meant to
be a memory limit.

-- 
Philippe.

