Message-ID: <2ff1a98a0802010118m75f51ed8gb01e87981b529a57@domain.hid>
Date: Fri, 1 Feb 2008 10:18:48 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390802010108l4f24cc4bq81272fdae55089e9@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390802010108l4f24cc4bq81272fdae55089e9@domain.hid>
Subject: Re: [Xenomai-core] rt_task_sleep doesn't work with round robin
	scheduling
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Feb 1, 2008 at 10:08 AM, axel axel <softaxel@domain.hid> wrote:
> Hi,
>
> i try to use rt_task_sleep( 10000000 ) in a user-space task under
> round-robin scheduling but doesnt' work.
>
> It returns the value -11.
>
> Any idea ?

Do you observe the same behaviour with xenomai trunk ?

-- 
                                               Gilles Chanteperdrix

