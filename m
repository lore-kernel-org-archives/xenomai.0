Message-ID: <4E5DF9DB.9090305@domain.hid>
Date: Wed, 31 Aug 2011 11:07:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E5DDB3D.8020804@domain.hid> <4E5DDED0.8070806@domain.hid>
	<4E5DE23B.40402@domain.hid>
In-Reply-To: <4E5DE23B.40402@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] do rt_task_create after a deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 08/31/2011 09:26 AM, Roberto Bielli wrote:
> Hi,
> 
> i explain better. if i don't use rt_task_join i remove the flag 
> T_JOINABLE, so i wait the task termination with a rt_task_create that 
> return -EEXIST.

The only way to wait for a thread to have freed all resources (notably
its stack) is to create it with T_JOINABLE and join it.

-- 
					    Gilles.

