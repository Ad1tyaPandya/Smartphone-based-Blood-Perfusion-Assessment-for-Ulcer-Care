import matlab.engine


def cool():
    eng = matlab.engine.start_matlab()
    eng.heatmap_gen(nargout=0)
    eng.quit()


def hot():
    eng = matlab.engine.start_matlab()
    eng.Hemoglobin_quantification(nargout=0)
    eng.quit()


def grey():
    eng = matlab.engine.start_matlab()
    eng.grey(nargout=0)
    eng.quit()


grey()
