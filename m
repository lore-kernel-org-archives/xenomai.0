Subject: Re: Can I use ftrace to analysis cobalt kernel
References: <2EEA4F9C-7739-425E-B57E-1BED69207E6B@aliyun.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <88960bcc-c77b-78a4-dd9c-5d5f7c81e4ce@siemens.com>
Date: Tue, 24 Aug 2021 15:21:57 +0200
MIME-Version: 1.0
In-Reply-To: <2EEA4F9C-7739-425E-B57E-1BED69207E6B@aliyun.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ivan Jiang <jcgeforce@aliyun.com>, xenomai@xenomai.org

On 24.08.21 14:48, Ivan Jiang via Xenomai wrote:
> Dear guys:
> 
>  
> 
>        Can I use ftrace to analysis the kernel with patch of ipipe.
> 
>        I find if use function_graph whe kernel will crash like below:
> 
>        echo function_graph > current_tracer
> 
> root@smarc-rzg2l:/sys/kernel/debug/tracing# [  377.392724] Kernel panic - not syncing: kernel stack overflow
> 
> [  377.399125] CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.19.140-cip33-g6634f0243a91 #3
> 
> [  377.407929] Hardware name: RZG2L Evaluation Board Kit (Discrete Power System Ver.) (Dual Cortex-A55) (DT)
> 

That's ARM64 and I-pipe - might not have been tested / fully enabled in
that combination. Try 5.10 with the dovetail patch, there ftrace is
known to work better. Alternatively: the I-pipe tracer should work on
arm64 (though without a nice function graph).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

