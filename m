From: Steven Seeger <steven.seeger@flightsystems.net>
Subject: Re: [PATCH] powerpc: ipipe: Do full exit checks after
 __ipipe_call_mayday
Date: Fri, 20 Dec 2019 19:14:28 -0500
Message-ID: <30328229.FlIjBx1lN1@omoikane>
In-Reply-To: <77ed81c9-e26f-a5ea-63c1-3135e7e18091@siemens.com>
References: <d93a6092-b340-b74b-ff3d-51ac5c438c25@siemens.com>
 <15932776.13ek4xDJqg@omoikane>
 <77ed81c9-e26f-a5ea-63c1-3135e7e18091@siemens.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

Jan,

I took a look at entry-common.S and entry_32.S and I think we have the correct 
check. The flow is a little different, but it seems to work as far as I can 
tell.

This was originally Philippe's code. Maybe he can take a quick look. ;)

Steven




