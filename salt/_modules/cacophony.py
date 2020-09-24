def continuous_recording(on):
    args = ["cacophony-config", "--write"]
    if on:
        args.extend([
            'thermal-throttler.activate=false',
            'thermal-motion.dynamic-threshold=false',
            'thermal-motion.temp-thresh=0',
            'thermal-motion.delta-thresh=0',
            'thermal-motion.count-thresh=0',
        ])
    else:
        args.extend([
            'thermal-throttler.activate=true',
            'thermal-motion.dynamic-threshold=true',
            'thermal-motion.temp-thresh=2900',
            'thermal-motion.delta-thresh=50',
            'thermal-motion.count-thresh=3',
        ])

    output = __salt__['cmd.run'](' '.join(args), raise_err=True)    
    __salt__['service.restart']('thermal-recorder')
    return output

