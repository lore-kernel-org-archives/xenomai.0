Message-ID: <43875924.7070903@domain.hid>
Date: Fri, 25 Nov 2005 19:34:12 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] private heaps for native pipes
References: <438756DA.9000808@domain.hid>
In-Reply-To: <438756DA.9000808@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> this is basically the last version of my rt_pipe_create-ext patch to add
> private, user-resizeable heaps to native pipes. Joerg has tested this
> patch successfully under the 2.1 trunk, and I added a ChangeLog snippet.
> Attached both 2.0.x and 2.1.x patches - please apply at least the 2.1
> variant.
> 

Applied to 2.1, thanks. We need to keep the 2.0 branch 100% compatible 
with the former RTAI/fusion API-wise, so I won't merge this in 2.0 though.

-- 

Philippe.

