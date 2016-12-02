MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 2 Dec 2016 14:03:31 +0100
Message-ID: <CAMJ=MEdM7O5OBjpQV8sYyVfpToJbuy24MMfDRouDeMaryGcR+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] =?utf-8?q?Question_about_config_option_=E2=80=93mem-poo?=
	=?utf-8?q?l-size?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

Context: I'm using the pSOS interface over the Mercury core (version 3.0.3)=
.

I have a question about option:
=E2=80=93mem-pool-size
described on page
http://xenomai.org/2015/05/application-setup-and-init/

Is the parameter specifying the maximum size that will be used Xenomai
or is this the initial value that will be used while creating the main
memory pool.

The explanation makes me think it is the first case while tests show
that it is the
latter case. e.g. the memory pool just extends when it is depleted.

To me it would make more sense that the parameter is specifying the maximum
memory that will be used since like it is today the application's
memory usage can
grow until all system memory is consumed.

Ronny

